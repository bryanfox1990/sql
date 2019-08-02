
CREATE TABLE dbo.Person
(
	PersonId INT NOT NULL,
	PersonName VARCHAR(25) NOT NULL,
	Country VARCHAR(10),
	DateAdded DATETIME CONSTRAINT DF_DateAdded DEFAULT GETDATE(),
	CONSTRAINT PK_Person_PersonID PRIMARY KEY CLUSTERED (PersonId)
)

EXEC sp_helpconstraint 'Person'

------------------
if object_id('alumnos') is not null
  drop table alumnos;

create table alumnos(
  legajo char(4) not null,
  apellido varchar(20),
  nombre varchar(20),
  documento char(8),
  domicilio varchar(30),
  ciudad varchar(30),
  notafinal decimal(4,2),
  campo varchar(10) constraint DF check (CAMPO in ('lunes','miercoles','viernes'))
);

go

-- Agregamos una restricción "primary" para el campo "legajo":
alter table alumnos
 add constraint PK_alumnos_legajo
 primary key(legajo);

 ALTER TABLE dbo.alumnos
 ADD mes varchar(20)
 CONSTRAINT	df_mes check (mes in ('lunes','miercoles','viernes'))




-- Agregamos una restricción "unique" para el campo "documento"
alter table alumnos
 add constraint UQ_alumnos_documento
 unique (documento);

-- Agregamos una restricción "check" para que el campo "notafinal" 
-- admita solamente valores entre 0 y 10:
alter table alumnos
 add constraint CK_alumnos_nota
 check (notafinal>=0 and notafinal<=10);

-- Agregamos una restricción "default" para el campo "ciudad":
alter table alumnos
 add constraint DF_alumnos_ciudad
 default 'Cordoba'
 for ciudad;

 -- Veamos las restricciones:
exec sp_helpconstraint alumnos;

-- Deshabilitamos la restricción "check":
alter table alumnos
  nocheck constraint CK_alumnos_nota;

 -- Veamos las restricciones:
exec sp_helpconstraint alumnos;




if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int not null,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(6,2)
);

go

-- Definimos una restricción "primary key" para nuestra tabla "libros" para asegurarnos 
-- que cada libro tendrá un código diferente y único:
alter table libros
 add constraint PK_libros_codigo
 primary key(codigo);

-- Definimos una restricción "check" para asegurarnos que el precio no será negativo:
alter table libros
 add constraint CK_libros_precio
 check (precio>=0);

-- Definimos una restricción "default" para el campo "autor" para que almacene "Desconocido":
alter table libros
 add constraint DF_libros_autor
 default 'Desconocido'
 for autor;

-- Definimos una restricción "default" para el campo "precio" para que almacene 0:
alter table libros
 add constraint DF_libros_precio
 default 0
 for precio;

-- Vemos las restricciones:
exec sp_helpconstraint libros;

-- Eliminamos la restricción "DF_libros_autor":
alter table libros
  drop DF_libros_autor;

-- Eliminamos la restricción "PK_libros_codigo":
alter table libros
  drop PK_libros_codigo;

exec sp_helpconstraint libros;
---------------------------------------

if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;
if object_id('autores') is not null
  drop table autores;

create table editoriales(
  codigo tinyint not null,
  nombre varchar(30),
  constraint PK_editoriales primary key (codigo)
);



create table autores(
  codigo int not null
   constraint CK_autores_codigo check (codigo>=0),
  nombre varchar(30) not null,
  constraint PK_autores_codigo
   primary key (codigo),
  constraint UQ_autores_nombre
    unique (nombre),
);

create table libros(
  codigo int identity,
  titulo varchar(40),
  codigoautor int not null,
  codigoeditorial tinyint not null,
  precio decimal(5,2)
   constraint DF_libros_precio default (0),
  constraint PK_libros_codigo
   primary key clustered (codigo),
  constraint UQ_libros_tituloautor
    unique (titulo,codigoautor),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on update cascade,
  constraint FK_libros_autores
   foreign key (codigoautor)
   references autores(codigo)
   on update cascade,
  constraint CK_libros_precio_positivo check (precio>=0)
);

go

exec sp_helpconstraint editoriales;

exec sp_helpconstraint autores;

exec sp_helpconstraint libros;



-------------------------------------------


if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table editoriales(
  codigo tinyint identity,
  nombre varchar(30),
  primary key (codigo)
);
 
create table libros (
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint,
  precio decimal(5,2),
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on update cascade,
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Paidos');
insert into editoriales values('Siglo XXI');

insert into libros values('Uno','Richard Bach',1,15);
insert into libros values('Ilusiones','Richard Bach',4,18);
insert into libros values('Puente al infinito','Richard Bach',2,20);
insert into libros values('Aprenda PHP','Mario Molina',4,40);
insert into libros values('El aleph','Borges',2,10);
insert into libros values('Antología','Borges',1,20);
insert into libros values('Cervantes y el quijote','Borges',3,25);

-- Mostramos los títulos de los libros de "Borges" de editoriales que 
-- han publicado también libros de "Richard Bach":
select titulo
  from libros
  where autor like '%Borges%' and
  codigoeditorial = any
   (select e.codigo
    from editoriales as e
    join libros as l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');

-- Realizamos la misma consulta pero empleando "all" en lugar de "any":
select titulo
  from libros
  where autor like '%Borges%' and
  codigoeditorial = all
   (select e.codigo
    from editoriales as e
    join libros as l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');

-- Mostramos los títulos y precios de los libros "Borges" cuyo precio 
-- supera a ALGUN precio de los libros de "Richard Bach":
 select titulo,precio
  from libros
  where autor like '%Borges%' and
  precio > any
   (select precio
    from libros
    where autor like '%Bach%');

-- Veamos la diferencia si empleamos "all" en lugar de "any":
 select titulo,precio
  from libros
  where autor like '%Borges%' and
  precio > all
   (select precio
    from libros
    where autor like '%Bach%');

-- Empleamos la misma subconsulta para eliminación:
 delete from libros
  where autor like '%Borges%' and
  precio > all
   (select precio
    from libros
    where autor like '%Bach%');

CREATE PROCEDURE sp_libros
@autor varchar(20)
AS
SELECT  *  FROM libros
WHERE autor LIKE '%' + @autor + '%'


create proc pa_libros_autor_editorial3
@autor varchar(30) = '%',
@editorial varchar(30) = '%'
as 
select titulo,autor,editorial,precio
from libros
where autor like @autor and
editorial like @editorial;

exec pa_libros_autor_editorial3 'P%';
exec pa_libros_autor_editorial3 @editorial='e%';
exec pa_libros_autor_editorial3 default, 'P%';

create procedure pa_promedio
@n1 decimal(4,2),
@n2 decimal(4,2),
@resultado decimal(4,2) output
as 
   select @resultado=(@n1+@n2)/2;


  declare @variable decimal(4,2)
  execute pa_promedio 5,6, @variable output
  select @variable;

 create procedure pa_autor_sumaypromedio
  @autor varchar(30)='%',
  @suma decimal(6,2) output,
  @promedio decimal(6,2) output
  as 
   select titulo,editorial,precio
   from libros
   where autor like @autor
  select @suma=sum(precio)
   from libros
   where autor like @autor
  select @promedio=avg(precio)
   from libros
   where autor like @autor;

    declare @s decimal(6,2), @p decimal(6,2)
 execute pa_autor_sumaypromedio 'Borges', @s output, @p output
 select @s as total, @p as promedio;

 DECLARE @valor varchar(30)
 SELECT   @valor = autor  FROM libros
 WHERE autor = 'borges'
 SELECT  @valor



 create procedure pa_libros_autor
  @autor varchar(30)=null
 as 
 if @autor is null
 begin 
  select 'Debe indicar un autor'
  return
 end;
 select titulo from  libros where autor = @autor;

  EXEC pa_libros_autor NULL

  exec sp_depends pa_libros_autor;
  exec sp_depends libros;

   select *from sysobjects
  where xtype='P' and-- tipo procedimiento
  name like 'pa%';--búsqueda con comodín


  ---------

  if object_id('libros') is not null
  drop table libros;
 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15)
);

go

-- Creamos un índice agrupado único para el campo "codigo" de la tabla "libros":
create unique clustered index I_libros_codigo
 on libros(codigo);

-- Creamos un índice no agrupado para el campo "titulo":
create nonclustered index I_libros_titulo
 on libros(titulo);

-- Veamos los indices de "libros":
exec sp_helpindex libros;

-- Creamos una restricción "primary key" al campo "codigo" especificando
-- que cree un índice NO agrupado:
alter table libros
  add constraint PK_libros_codigo
  primary key nonclustered (codigo);

-- Verificamos que creó un índice automáticamente:
exec sp_helpindex libros;

-- Analicemos la información que nos muestra "sp_helpconstraint":
exec sp_helpconstraint libros;

-- Creamos un índice compuesto para el campo "autor" y "editorial":
create index I_libros_autoreditorial
 on libros(autor,editorial);

-- Consultamos la tabla "sysindexes":
select name from sysindexes;

-- Veamos los índices de la base de datos activa creados por nosotros
-- podemos tipear la siguiente consulta:
select name from sysindexes
  where name like 'I_%';

   create nonclustered index I_libros
 on libros(titulo);
Regeneramos el índice "I_libros" y lo convertimos a agrupado:

 create clustered index I_libros
 on libros(titulo)
 with drop_existing;
Agregamos un campo al índice "I_libros":

 create clustered index I_libros
 on libros(titulo,editorial)
 with drop_existing;



 alter function f_nombreMes
 (@fecha datetime)
  returns varchar(10)
  as
  begin
    declare @nombre varchar(10)
    set @nombre=
     case datename(month,@fecha)
       when 'January' then 'Enero'
       when 'February' then 'Febrero'
       when 'March' then 'Marzo'
       when 'April' then 'Abril'
       when 'May' then 'Mayo'
       when 'June' then 'Junio'
       when 'July' then 'Julio'
       when 'agosto' then 'Agosto'
       when 'September' then 'Setiembre'
       when 'October' then 'Octubre'
       when 'November' then 'Noviembre'
       when 'December' then 'Diciembre'
     end--case
    return @nombre
 end;


create function f_fechaCadena
 (@fecha varchar(25))
  returns varchar(25)
  as
  begin
    declare @nombre varchar(25)
    set @nombre='Fecha inválida'   
    if (isdate(@fecha)=1)
    begin
      set @fecha=cast(@fecha as datetime)
      set @nombre=
      case datename(month,@fecha)
       when 'January' then 'Enero'
       when 'February' then 'Febrero'
       when 'March' then 'Marzo'
       when 'April' then 'Abril'
       when 'May' then 'Mayo'
       when 'June' then 'Junio'
       when 'July' then 'Julio'
       when 'August' then 'Agosto'
       when 'September' then 'Setiembre'
       when 'October' then 'Octubre'
       when 'November' then 'Noviembre'
       when 'December' then 'Diciembre'
      end--case
      set @nombre=rtrim(cast(datepart(day,@fecha) as char(2)))+' de '+@nombre
      set @nombre=@nombre+' de '+ rtrim(cast(datepart(year,@fecha)as char(4)))
    end--si es una fecha válida
    return @nombre
 end;


 SELECT dbo.f_nombreMes(getdate()) AS fecha


 ---------

  create function f_ofertas
 (@minimo decimal(6,2))
 returns @ofertas table-- nombre de la tabla
 --formato de la tabla
 (codigo int,
  titulo varchar(40),
  autor varchar(30),
  precio decimal(6,2)
 )
 as
 begin
   insert @ofertas
    select codigo,titulo,autor,precio
    from libros
    where precio < @minimo
   return
 end;

  select *from f_ofertas(30);
 select *from dbo.f_ofertas(30);


  create function f_libros
 (@autor varchar(30)='Borges')
 returns table
 as
 return (
  select titulo,editorial
  from libros
  where autor like '%'+@autor+'%'
 );

 select name,xtype as tipo,crdate as fecha
  from sysobjects
  where xtype in ('FN','TF','IF');


  SELECT 
   first_name, 
   last_name, 
   city,
   ROW_NUMBER() OVER (
      PARTITION BY city
      ORDER BY first_name
   ) row_num
FROM 
   sales.customers
ORDER BY 
   city;


   WITH cte_customers AS (
    SELECT 
        ROW_NUMBER() OVER(
             ORDER BY 
                first_name, 
                last_name
        ) row_num, 
        customer_id, 
        first_name, 
        last_name
     FROM 
        sales.customers
) SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    cte_customers
WHERE 
    row_num > 20 AND 
    row_num <= 30;



	BEGIN TRY  
    -- RAISERROR con 'severity' 11-19 para causar la ejecución de bloque CATCH  
    RAISERROR ('Error raised in TRY block.', 
               16, -- Severity.  
               1 -- State.  
               );  
END TRY  
BEGIN CATCH  
    DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  

    -- RAISE ERROR en bloque catch para forzar la devolución de error personalizado
    RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State.  
               );  
END CATCH;



	BEGIN TRY
     BEGIN TRANSACTION
          UPDATE cuentas SET balance = balance - 1250 WHERE nombreCliente = 'Antonio';
          UPDATE cuentas SET balance = balance + 1250 WHERE nombreCliente = 'Claudio';
     COMMIT TRANSACTION  
     PRINT 'Transacción completada'
END TRY
BEGIN CATCH
     ROLLBACK TRANSACTION
     PRINT 'Transacción cancelada'
END CATCH


------------------------------


if object_id('ventas') is not null
  drop table ventas;
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  precio decimal(6,2), 
  stock int,
  constraint PK_libros primary key(codigo)
);

create table ventas(
  numero int identity,
  fecha datetime,
  codigolibro int not null,
  precio decimal (6,2),
  cantidad int,
  constraint PK_ventas primary key(numero),
  constraint FK_ventas_codigolibro
   foreign key (codigolibro) references libros(codigo)
);

go

insert into libros values('Uno','Richard Bach',15,100);
insert into libros values('Ilusiones','Richard Bach',18,50);
insert into libros values('El aleph','Borges',25,200);
insert into libros values('Aprenda PHP','Mario Molina',45,200);

go

-- Creamos un disparador para que se ejecute cada vez que una instrucción "insert" 
-- ingrese datos en "ventas"; el mismo controlará que haya stock en "libros"
-- y actualizará el campo "stock":
create trigger DIS_ventas_insertar
  on ventas
  for insert
  as
   declare @stock int
   select @stock= stock from libros
		 join inserted
		 on inserted.codigolibro=libros.codigo
		 where libros.codigo=inserted.codigolibro
  if (@stock>=(select cantidad from inserted))
    update libros set stock=stock-inserted.cantidad
     from libros
     join inserted
     on inserted.codigolibro=libros.codigo
     where codigo=inserted.codigolibro
  else
  begin
    raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
    rollback transaction
  end

go

set dateformat ymd;

-- Ingresamos un registro en "ventas":
insert into ventas values('2018/04/01',1,15,1);
-- Al ejecutar la sentencia de inserción anterior, se disparó el trigger, el registro
-- se agregó a la tabla del disparador ("ventas") y disminuyó el valor del campo "stock"
-- de "libros".

-- Verifiquemos que el disparador se ejecutó consultando la tabla "ventas" y "libros":
select * from ventas;
select * from libros where codigo=1;

-- Ingresamos un registro en "ventas", solicitando una cantidad superior al stock 
-- (El disparador se ejecuta y muestra un mensaje, la inserción no se realizó porque
-- la cantidad solicitada supera el stock.):
 insert into ventas values('2018/04/01',2,18,100);

 -- Finalmente probaremos ingresar una venta con un código de libro inexistente
 -- (El trigger no llegó a ejecutarse, porque la comprobación de restricciones 
 -- (que se ejecuta antes que el disparador) detectó que la infracción a la "foreign key"):
 insert into ventas values('2018/04/01',5,18,1);



 create trigger DIS_ventas_borrar
  on ventas
  for delete 
 as
   update libros set stock= libros.stock+deleted.cantidad
   from libros
   join deleted
   on deleted.codigolibro=libros.codigo;

GO

create trigger DIS_libros_borrar
  on libros
  for delete
  as
   if (select count(*) from deleted) > 1
   begin
    raiserror('No puede eliminar más de un libro',16,1)
    rollback transaction
   end;


    create trigger DIS_libros_actualizar2
  on libros
  for update
  as
   if (update(titulo) or update(autor) or update(editorial)) and
    not (update(precio) or update(stock))
   begin
    select d.codigo,
    (d.titulo+'-'+ d.autor+'-'+d.editorial) as 'registro anterior',
    (i.titulo+'-'+ i.autor+'-'+i.editorial) as 'registro actualizado'
     from deleted as d
     join inserted as i
     on d.codigo=i.codigo
   end
   else
   begin
    raiserror('El precio y stock no pueden modificarse. La actualización no se realizó.', 10, 1)
    rollback transaction
   end;


    select name,xtype as tipo,crdate as fecha
  from sysobjects
  where xtype = 'TR';


   if object_id('dis_libros_insertar') is not null
  drop trigger dis_libros_insertar; 

  alter table empleados
  disable trigger dis_empleados_borrar;


  create trigger dis_libros_actualizar
 on libros
 after update
 as
  if exists (select *from inserted where stock<0)
  begin
   update libros set stock=deleted.stock
   from libros
   join deleted
   on deleted.codigo=libros.codigo
   join inserted
   on inserted.codigo=libros.codigo
   where inserted.stock<0;
  end;


  DECLARE @ITEM_ID uniqueidentifier  -- Here we create a variable that will contain the ID of each row.
 
DECLARE ITEM_CURSOR CURSOR  -- Here we prepare the cursor and give the select statement to iterate through
FOR
SELECT ITEM_ID
FROM #ITEMS
 
OPEN ITEM_CURSOR -- This charges the results to memory
 
FETCH NEXT FROM ITEM_CURSOR INTO @ITEM_ID -- We fetch the first result
 
WHILE @@FETCH_STATUS = 0 --If the fetch went well then we go for it
BEGIN
 
SELECT ITEM_DESCRIPTION -- Our select statement (here you can do whatever work you wish)
FROM #ITEMS
WHERE ITEM_ID = @ITEM_ID -- In regards to our latest fetched ID
 
FETCH NEXT FROM ITEM_CURSOR INTO @ITEM_ID -- Once the work is done we fetch the next result
 
END
-- We arrive here when @@FETCH_STATUS shows there are no more results to treat
CLOSE ITEM_CURSOR  
DEALLOCATE ITEM_CURSOR -- CLOSE and DEALLOCATE remove the data from memory and clean up the p



create Table TempVentas
(cliente  varchar(50) null,
anio int null,
Importe numeric(18,2) null)
Go
Insert into TempVentas(cliente,anio,importe) values ('CL1',2010,110.20)
Insert into TempVentas(cliente,anio,importe) values ('CL1',2011,90.10)
Insert into TempVentas(cliente,anio,importe) values ('CL1',2012,110.20)
Insert into TempVentas(cliente,anio,importe) values ('CL3',2011,45.99)
Insert into TempVentas(cliente,anio,importe) values ('CL3',2013,219.99)
Insert into TempVentas(cliente,anio,importe) values ('CL2',2017,12.17)
Insert into TempVentas(cliente,anio,importe) values ('CL2',2017,66.45)
Insert into TempVentas(cliente,anio,importe) values ('CL2',2016,22.18)
Insert into TempVentas(cliente,anio,importe) values ('CL2',2015,40.20)
Insert into TempVentas(cliente,anio,importe) values ('CL1',2014,65.10)

SELECT  *  FROM dbo.TempVentas tv

Select Cliente,[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017] from tempventas
pivot(
Sum(importe)
for  anio in ([2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017])
) as TablaTempPIVOT