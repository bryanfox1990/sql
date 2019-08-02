
delete  from  REPORTES.dbo.reporte_conexion
delete  from reportes.dbo.reporte


insert into REPORTES.dbo.reporte_conexion (id_ejec, ventas,previsto,horas,fecha,dia,semana)
exec usp_listado_conexion '07/03/2019' -- AQUI VA LA ULTIMA FECHA


-- INSERTAR HASTA EL DIA ANTERIOR

insert into reportes.dbo.reporte
exec usp_listado '01/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '02/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '03/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '04/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '05/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '06/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '07/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '08/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '09/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '10/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '11/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '12/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '13/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '14/03/2019','marzo'
insert into reportes.dbo.reporte    
exec usp_listado '15/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '16/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '17/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '18/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '19/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '20/03/2019','marzo'

---------------------------------------------

insert into reportes.dbo.reporte
exec usp_listado '21/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '22/03/2019','marzo'
insert into reportes.dbo.reporte
exec usp_listado '23/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '24/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '25/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '26/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '27/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '28/03/2019','marzo'

------------------------------------------

insert into reportes.dbo.reporte
exec usp_listado '29/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '30/03/2019','marzo'

insert into reportes.dbo.reporte
exec usp_listado '31/03/2019','marzo'
--------------------------------------------
select  SUM(ventas)  from REPORTES.dbo.reporte
select  SUM(ventas)  from REPORTES.dbo.reporte_conexion

----------------------------------------------------------------------------------------------
--------- EJECUTAR ESTAS CONSULTAS COMO BASE PARA OBTENER LA PESTAÑA DATA Y DATA_HORAS ------

drop table #dotacion
drop table #ddni

-- PASO 1: SE CREA LA TABLA #DOTACION

create table #ddni               
(le_10 varchar(12) null , vigen_10tc char(1) null , fcoi2_10tc date  null)              
              
insert into #ddni              
select  ltrim(rtrim(le_10)) as le_10 , vigen_10tc , fcoi2_10tc   from  [SRV-DC10\SQL2012].custom_cmvalservicios.dbo.cag1000 u                                                 
--on right('00000000'+convert(varchar(255),ltrim(rtrim(u.le_10))),8)=t.nro_dni                  
inner join  [SRV-DC10\SQL2012].custom_cmvalservicios.dbo.cag10tc  m on u.fichp_10=m.fich_10tc and vigen_10tc = '1'    


select  *  into #dotacion from (
SELECT   
t.id_trab, g.id_gest_fam ,            
t.nro_dni as DNI,          
t.USERNAME AS EJEC,          
t.comp_trab as EJECUTIVO,   
desc_gest_fam + '' +t.comp_trab as COMBI ,  
--convert(char(10),fech_ing_trab,103) as 'FIContrato', 
convert(char(10),fcoi2_10tc,103) as 'FIContrato', 
convert(varchar(4),DATEDIFF(MONTH,convert(date,fech_ing_trab,103), getdate())) as Antiguedad ,                 
case when t.est_trab = '1' then 'ACTIVO' else 'BAJA' end as estado,                         
desc_gest_fam as CAMPANA,           
desc_gest as 'SUBCAMPANA',  
ISNULL(ts.nom_superv,t.id_superv) AS SUPERVISOR  ,
t.id_tt                                
FROM cmyval.dbo.TRABAJADOR t               
inner join cmyval.dbo.tipotrabajador tp on t.id_tt=tp.id_tt  
left join #ddni d on d.le_10 = t.nro_dni              
left join (select  id_trab, id_trab_int, id_superv, comp_trab as nom_superv  from cmyval.dbo.Trabajador where est_trab = '1')  ts   on ts.id_trab_int = t.id_superv           
left join cmyval.dbo.gestion g on g.id_gest=t.id_tgest                         
) a

-- PASO 2: SE BORRA LOS REGISTROS DE LA TABLA  cmyval.dbo.historico_SupervXEmp
delete from cmyval.dbo.historico_SupervXEmp

-- PASO 3: SE INSERTA REGISTROS EN LA TABLA  cmyval.dbo.historico_SupervXEmp
insert into cmyval.dbo.historico_SupervXEmp
select  id_emp, e.id_gest,g.desc_gest,id_gest_sefam, g.desc_gest_fam,e.id_superv, s.comp_trab as supervisor, est_gest_original, e.id_fech_crea  from cmyval.dbo.SupervXEmp e
inner join cmyval.dbo.Trabajador s on e.id_superv = s.id_trab
inner join cmyval.dbo.Gestion g on g.id_gest = e.id_gest
where est_sxe = '1' and est_se = '1' and est_eg = '1' and est_gest_original = '1' 
and id_emp+e.id_gest+convert(char(3),id_gest_sefam)+e.id_superv
 not in (select   id_emp+id_gest+convert(char(3),id_gest_sefam)+id_superv  from cmyval.dbo.historico_SupervXEmp )
 and  id_emp+CONVERT(char(10),e.id_fech_crea,103) in (select  id_emp+CONVERT(char(10),max(id_fech_crea),103)  from SupervXEmp
 where est_sxe = '1' 
 group by id_emp,convert(char(10),id_fech_crea,103) )
 
-- PASO 4: EJECUTAMOS ESTAS 3 CONSULTAS
update  cmyval.dbo.historico_SupervXEmp
set est_gest_original = 0
from cmyval.dbo.historico_SupervXEmp se
 inner join Trabajador t on t.id_trab = se.id_emp
 where est_gest_original = '1' and t.id_tgest <> se.id_gest

update  cmyval.dbo.historico_SupervXEmp
set est_gest_original = 1
from cmyval.dbo.historico_SupervXEmp se
 inner join Trabajador t on t.id_trab = se.id_emp
 where est_gest_original = '0' and t.id_tgest = se.id_gest 

update cmyval.dbo.historico_SupervXEmp
set est_gest_original = 0
where id not in (select max(id)  from cmyval.dbo.historico_SupervXEmp where id_emp in ('EMP001862') )
and id_emp = 'EMP001862'


-------------------

-- PASO 1: BORRAR REGISTROS REPORTE_CONEXION
drop table #asistencia
drop table #proyectado_asistencia
drop table #seguimiento

-- PASO 2: EJECUTAR EL PROCEDURE FILTRANDO LA FECHA ULTIMA
-- OJO AL IGUAL QUE EL PROCEDURE  usp_listado SE EJECUTAN LAS CAMPAÑAS QUE ESTAN HABILITADOS SI HAY NUEVAS CAMPAÑAS
-- SE AGREGA EL CODIGO DE LA CAMPAÑA, EN TODO CASO REVISAR EL PROCEDURE PARA MEJOR COMPRESION.

---------------------------------------------------------------------------------------------------------------------
-- PASO 3: PARA CREAR LA TABLA #CONEXIONES_VENTAS
drop table #conexiones_ventas

SELECT  *  INTO #conexiones_ventas from (
select  id_ejec,ejecutivo,dni,ejec,LTRIM(RTRIM(EJECUTIVO))+' ('+estado+')' as EJECUTIVO2,FIContrato,round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) as 'Fecha Mes'
,case when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) <= 1 then  '< 01 mes'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) between 1 and 3 then '1 a 3 Meses'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) between 3 and 5.99 then '3 Meses'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) > = 6 then '6 Meses'
else '0' end as Antiguedad
,estado, campana,SUBCAMPANA,supervisor,ventas,previsto,r.horas,r.fecha, r.dia, 'Semana' +' '+ r.semana   as semana
,CASE WHEN  estado = 'ACTIVO' then '1' else '0' end as 'ACTIVADOR' , tt.desc_tt
  from REPORTES.dbo.reporte_conexion  r
INNER join #dotacion d on d.id_trab = r.id_ejec 
left join TipoTrabajador tt on tt.id_tt = d.id_tt
) a 


UPDATE #conexiones_ventas
SET ACTIVADOR = 0
where id_ejec in (select id_trab from cmyval.dbo.trabajador where id_tt in ('TT004','TT015','TT016','TT018') and est_trab = '1' )
--3
update #conexiones_ventas
set ACTIVADOR = 0
where id_ejec in ('EMP001862','EMP000747') 


---------------------------------------------------------------------------------------------------------------------------------------
-- PASO 5 : CREAMOS LA TABLA #PRUEBA
drop table #prueba

select  *  into #prueba from  (
select 
id_ejec ,
LTRIM(RTRIM(EJECUTIVO)) as detalle,
dni,ejec,LTRIM(RTRIM(EJECUTIVO))+' ('+estado+')' as EJECUTIVO
--,isnull(se.desc_gest_fam, CAMPANA )  + LTRIM(RTRIM(EJECUTIVO))  AS COMBI  
,g.desc_gest_fam + LTRIM(RTRIM(EJECUTIVO))  AS COMBI  
,FIContrato
,round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) as 'Fecha Mes'
,case when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) <= 1 then  '< 01 mes'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) between 1 and 3 then '1 a 3 Meses'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) between 3 and 5.99 then '3 Meses'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) > = 6 then '6 Meses'
else '0' end as Antiguedad
,estado
,g.desc_gest_fam as campana                         
,g.desc_gest as subcampana
,D.SUPERVISOR 
,tramitados, contactos,potenciales, ventas, errores, previsto,r.horas,fecha, dia, 'Semana' +' '+semana   as semana
,CASE WHEN est_gest_original = 1 and estado = 'ACTIVO' then '1' else '0' end as 'ACTIVADOR' 
from reportes.dbo.reporte r
INNER join #dotacion d on d.id_trab = r.id_ejec 
inner join Gestion g on g.id_gest = r.id_gest
left join cmyval.dbo.historico_SupervXEmp  se on se.id_emp = r.id_ejec AND se.id_gest = g.id_gest and est_gest_original = '1'
where DATENAME(month,r.fecha) = 'marzo' 
) a 

UPDATE #prueba
SET ACTIVADOR = 0
where id_ejec in (select id_trab from cmyval.dbo.trabajador where id_tt in ('TT004','TT015','TT016','TT018') and est_trab = '1' )
--3
update #prueba
set ACTIVADOR = 0
where id_ejec in ('EMP001862','EMP000747') 

-- PASO 7: COMPROBAMOS LAS VENTAS , DEBEN COINCIDIR

select sum(ventas)  from reportes.dbo.reporte_conexion
SELECT SUM(VENTAS) FROM REPORTES.DBO.REPORTE
select sum(ventas) from #prueba
select sum(ventas) from  #conexiones_ventas

select  sum(cantidad)  from #ventas


----//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////---
----///////////////////////////////////////////////////LISTA DE ASESORES Y SUS TRAMITADOS/////////////////////////////////////////////////////////////////////---
----//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////---

drop table #tramitado

CREATE TABLE #tramitado
(
id_ejec char(9),
comp_trab varchar(100),
fecha  char(10),
cantidad int
)
-- SE INSERTAR HASTA EL DIA ANTERIOR DE LA GESTION

Insert into #tramitado
select distinct id_ejec, comp_trab, CONVERT(char(10),fech_reg_ejec,103) as fecha,count(distinct id_univ) as cantidad  
from cmyval.dbo.Universo u WITH (NOLOCK)
inner join CMYVAL.DBO.carterauniverso cu on u.id_cu = cu.id_cu
left join cmyval.dbo.Trabajador t on u.id_ejec = t.id_trab
where datename(month,fech_reg_ejec) = 'marzo' and fech_reg_ejec_general is not null  --and id_c_general <> '0'
and id_ejec not in ('EMP000747','EMP001862','EMP009362')
and fech_reg_ejec_general 
BETWEEN CAST('01/03/2019' AS datetime)      
                  AND DATEADD(second,-1,DATEADD(day,1,CAST('06/03/2019' AS datetime))) 
and mes = 'marzo' and año = '2019' and cu.id_gest_fam in ('204','203','225','226','228','212','230','206','233','236','232','237','239')    
GROUP BY id_ejec,comp_trab , CONVERT(char(10),fech_reg_ejec,103)
order by comp_trab, fecha




----//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////---
----///////////////////////////////////////////////////LISTA DE ASESORES Y SUS VENTAS/////////////////////////////////////////////////////////////////////---
----//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////---

drop table  #ventas
drop table #not
drop table #nv

CREATE TABLE #ventas
(
id_rejec char(9),
comp_trab varchar(100),
fecha  char(10),
cantidad int
)

-- SE INSERTAR HASTA EL DIA ANTERIOR DE LA GESTION

insert into #ventas
select  distinct id_rejec ,comp_trab, CONVERT(char(10),fechapreventa,103) as dia,count( r.id_univ) as cantidad 
from cmyval.dbo.RegistroVenta r WITH (NOLOCK)
--INNER JOIN universo u on u.id_univ  = r.id_univ 
inner join carterauniverso cu on r.id_rcu = cu.id_cu
left JOIN cmyval.dbo.Trabajador t on t.id_trab = r.id_rejec
where   datename(MONTH,fechapreventa) = 'marzo' and year(fechapreventa) ='2019' and r.est_rv = '1'
and cu.id_gest_fam in ('204','203','225','228','212','233','239','232')     
AND fechapreventa
BETWEEN CAST('01/03/2019' AS datetime)      
                  AND DATEADD(second,-1,DATEADD(day,1,CAST('06/03/2019' AS datetime))) 
group by id_rejec,comp_trab, CONVERT(char(10),fechapreventa,103)




select  *  into #not from (
select  distinct u.id_ejec,comp_trab, CONVERT(char(10),fecha,103) as dia,0 as cantidad 
from Universo u WITH (NOLOCK)
inner join carterauniverso cu on cu.id_cu = u.id_cu 
inner join #tramitado t on t.id_ejec = u.id_ejec
where   datename(MONTH,fecha) = 'marzo' and year(fecha) ='2019' 
and cu.id_gest_fam in ('204','203','225','226','228','212','230','206','233','236','232','237','239','232')    
group by u.id_ejec,comp_trab, CONVERT(char(10),fecha,103)
) a


SELECT  *  INTO #nv from (
select distinct   id_rejec from cmyval.dbo.RegistroVenta 
where datename(month,fechapreventa) = 'marzo' and year(fechapreventa) = '2019' and est_rv = '1'  ) a 


insert into #ventas
select  u.id_ejec,u.comp_trab,u.dia,cantidad  from #not u
where u.id_ejec not in ( select  id_rejec from #nv)




select  *  into #comp from (
select d.id_trab,
LTRIM(RTRIM(EJECUTIVO)) as detalle,
dni,ejec
,FIContrato
,round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) as 'Fecha Mes'
,case when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) <= 1 then  '< 01 mes'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) between 1 and 3 then '1 a 3 Meses'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) between 3 and 5.99 then '3 Meses'
when round(cast (DATEDIFF(day,Ficontrato,getdate()) as float) / cast(30 as float),2) > = 6 then '6 Meses'
else '0' end as Antiguedad
,estado
,SUBCAMPANA,SUPERVISOR ,id_tt
from  #dotacion d 
) a 


 -------------------------------------------------------------
 --  EJECUTAMOS Y PEGAMOS EN LAS PESTAÑAS

 --1. COPIAMOS EN LA PESTAÑA VENTAS
declare @colsWithNoNulls varchar(max)      
set @colsWithNoNulls = ''      
select @colsWithNoNulls = coalesce(@colsWithNoNulls + 'ISNULL([' + fecha + '], ''0'')', '') +' '+ QUOTENAME(fecha)+','      
FROM (select CONVERT(char(10),fecha,103) as fecha from cmyval.dbo.calendario where mes ='marzo' and YEAR(fecha) = '2019'  and fecha <= (select distinct convert(date,max(fechapreventa)) from registroventa )) as DTM   order by fecha   
set @colsWithNoNulls = left(@colsWithNoNulls,LEN(@colsWithNoNulls)-1) 

declare @columnas varchar(max)      
set @columnas = ''      
select @columnas = coalesce(@columnas + '[' + fecha + '],', '')      
FROM (select CONVERT(char(10),fecha,103) as fecha from cmyval.dbo.calendario where mes ='marzo' and YEAR(fecha) = '2019'  and fecha <= (select distinct convert(date,max(fechapreventa)) from registroventa ) ) as DTM  order by fecha    
set @columnas = left(@columnas,LEN(@columnas)-1)   
   
DECLARE @SQLString nvarchar(3000);      
set @SQLString = 'select dni,comp_trab,Antiguedad,supervisor,subcampana,estado, '+@columnas+'  from  (    
Select dni,comp_trab,Antiguedad,supervisor,estado ,subcampana, '+@colsWithNoNulls+' from               
( select  dni,comp_trab,Antiguedad,supervisor,estado , fecha, cantidad, subcampana from #ventas v
inner join #comp c on v.id_rejec = c.id_trab     

) as DataSource              
pivot              
( sum(cantidad) for fecha in (' + @columnas + ')             
)as DataPivot    
) as a  order by comp_trab '      
EXECUTE sp_executesql @SQLString    



--2 : SE COPIA EL RESULTADO A LA PESTAÑA DATA
select  id_ejec,detalle,dni,ejec,EJECUTIVO,COMBI,FIContrato,Fecha Mes,Antiguedad,estado,CAMPANA,SUBCAMPANA,
SUPERVISOR,tramitados,contactos,potenciales,ventas,errores,previsto,horas,fecha,dia,
semana,ACTIVADOR , tt.desc_tt, fl_cuartil1,fl_cuartil2, fl_cuartil3, fl_cuartil4 
from #prueba c
inner join Trabajador t on t.id_trab = c.id_ejec
inner join TipoTrabajador tt on tt.id_tt = t.id_tt 
order by detalle, dia


--3 : SE COPIA EL RESULTADO A LA PESTAÑA DATA_HORAS
select  c.* ,fl_cuartil1, fl_cuartil2, fl_cuartil3, fl_cuartil4  from  #conexiones_ventas c
inner join Trabajador t on t.id_trab = c.id_ejec
inner join TipoTrabajador tt on tt.id_tt = t.id_tt 



--- ESTO ES SOLO PARA VALIDAR
select sum(ventas)  from reportes.dbo.reporte_conexion
SELECT SUM(VENTAS) FROM REPORTES.DBO.REPORTE
select sum(ventas) from #prueba
select sum(ventas) from  #conexiones_ventas

select  sum(cantidad)  from #ventas

----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
----//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////---
----///////////////////////////////////////////////////LISTA DE ASESORES Y SUS CONEXIONES/////////////////////////////////////////////////////////////////////---
----//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////---

--EJECUTAR, LLENAR LA TABLA TEMP d 
drop table #horas_auxiliar
drop table #horas_asesores


select  *  into #horas_auxiliar from ( 
                       
select  id_ejec,fecha,sum(segundos) as segundos from ( 

select  id_ejec , convert(date,fech_desconectado) as fecha ,sum(segundos) as segundos  from tiempoAuxiliarEjec                        
where tipo = 'C' and convert(date,fech_desconectado) < convert(date,getdate())        
and datename(MONTH,fech_desconectado) = 'marzo' and YEAR(fech_desconectado) = '2019'                      
group by id_ejec , convert(date,fech_desconectado)                     
union                         
select  id_ejec, convert(date,fech_t) as fecha ,sum(segundos) as segundos  from tiempoTipificacionEjec                        
where  convert(date,fech_t) < convert(date,getdate())               
and datename(month,fech_t)    = 'marzo'  and YEAR(fech_t) = '2019'                      
group by id_ejec ,convert(date,fech_t)                         
union                        
select id_ejec, convert(date,fech_t) as fecha , sum(segundos) as segundos   from tiempoVentaEjec                        
where convert(date,fech_t) < convert(date,getdate())               
and datename(month,fech_t)    = 'marzo'  and YEAR(fech_t) = '2019'                              
group by id_ejec ,convert(date,fech_t)                      

) b                       
group by id_ejec,fecha                      

) a  

--- PEGAR ESTO EN LA PESTAÑA HOJA2

select 
t.id_trab
,t.comp_trab,  CONVERT(char(10),u.fecha,103) as fecha
,sum(duration) as segundos
, CONVERT(char(8),DATEADD(SECOND,sum(duration),0),114) as tiempo
from REPORTES.dbo.conexion_asesores u   
inner join cmyval.dbo.Trabajador t on u.id_ejec = t.id_trab
where datename(MONTH,u.fecha) = 'marzo' and year(u.fecha) = '2019'
group by t.id_trab,t.comp_trab,CONVERT(char(10),u.fecha,103)
union
select  t.id_trab,t.comp_trab, convert(char(10),fecha,103),sum(segundos), CONVERT(char(8),DATEADD(SECOND,sum(segundos),0),114) as tiempo from #horas_auxiliar h
inner join Trabajador t on  h.id_ejec = t.id_trab
group by  t.id_trab,t.comp_trab, convert(char(10),fecha,103)






