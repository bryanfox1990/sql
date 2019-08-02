select count(*) from registroventa

DBCC SHOW_STATISTICS ('dbo.registroventa','PK_RegistroVenta')
DBCC SHOW_STATISTICS ('dbo.registroventa','ix_iduniv_fechapreventa')
DBCC SHOW_STATISTICS ('dbo.registroventa','ix_est_rvIncludes')

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'registroventa'

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.registroventa'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');
 
 

ALTER INDEX [PK_RegistroVenta_1]  ON registroventa rebuild; --2
ALTER INDEX [PK_RegistroVenta]  ON registroventa rebuild; --2
ALTER INDEX [ix_iduniv_fechapreventa]  ON registroventa rebuild; --89
ALTER INDEX [ix_fechapreventa]  ON registroventa rebuild; --90
ALTER INDEX [ix_est_rvIncludes]  ON registroventa rebuild; -- 91
ALTER INDEX [ix_fechregesc_idtrabesc]  ON registroventa rebuild; -- 93
ALTER INDEX [ix_fechregesc]  ON registroventa rebuild; -- 92
ALTER INDEX [ix__id_rcu_est_rv]  ON registroventa rebuild; -- 103

UPDATE STATISTICS dbo.registroventa PK_RegistroVenta
UPDATE STATISTICS dbo.registroventa ix_iduniv_fechapreventa
UPDATE STATISTICS dbo.registroventa ix_fechapreventa
UPDATE STATISTICS dbo.registroventa ix_est_rvIncludes
UPDATE STATISTICS dbo.registroventa ix_fechregesc_idtrabesc
UPDATE STATISTICS dbo.registroventa ix_fechregesc
UPDATE STATISTICS dbo.registroventa [ix__id_rcu_est_rv]

--------------------------------------------------------------------------
select count(*) from CarteraUniverso
DBCC SHOW_STATISTICS ('dbo.carterauniverso','PK_CarteraUniverso')
DBCC SHOW_STATISTICS ('dbo.carterauniverso','ix_mes_anio')


--exec sp_BlitzCache 
--exec sp_BlitzFirst

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'carterauniverso'

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.carterauniverso'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [Pk_carterauniverso]  ON carterauniverso reorganize;
ALTER INDEX [ix_mes_anio]  ON carterauniverso reorganize;
ALTER INDEX [ix_mes_anio_idgestfam_include]  ON carterauniverso reorganize;

UPDATE STATISTICS dbo.carterauniverso Pk_carterauniverso
UPDATE STATISTICS dbo.carterauniverso ix_mes_anio

--------------------------------------------------------
select count(*) from DataCampUniverso
DBCC SHOW_STATISTICS ('dbo.datacampuniverso','PK_DataCampUniverso_1')
DBCC SHOW_STATISTICS ('dbo.datacampuniverso','ix_idcu_id_dgest_telefono1')


--
exec sp_BlitzCache 
exec sp_BlitzFirst
exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'datacampuniverso'


DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.datacampuniverso'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');


ALTER INDEX [PK_DataCampUniverso_1]  ON datacampuniverso rebuild;
ALTER INDEX [ix_idcu_id_dgest_telefono1]  ON datacampuniverso rebuild;

UPDATE STATISTICS dbo.datacampuniverso PK_DataCampUniverso_1
UPDATE STATISTICS dbo.datacampuniverso ix_idcu_id_dgest_telefono1


SELECT COUNT(*) FROM DataCampUniverso
DBCC SHOW_STATISTICS ('dbo.datacampuniverso','PK_DataCampUniverso_1')



---------------------------------------------------------------------------------------
exec sp_BlitzCache 
exec sp_BlitzFirst
exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'universo'

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.universo'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');


ALTER INDEX [PK_Universo]  ON universo rebuild; -- 2
ALTER INDEX [PK_Universo_id]  ON universo rebuild; -- 1
ALTER INDEX [ix_fech_reg_ejec]  ON universo rebuild;--3
ALTER INDEX [ix_teleuniv1_idsuperv_idejec_idcu]  ON universo REBUILD; -- 86  -- SIEMPRE
ALTER INDEX [ix_fech_reg_ejec_general]  ON universo rebuild; --87 -- siempre
ALTER INDEX [ix_id_c_general_id_ejecIncludes]  ON universo REBUILD;--89 -- SIEMPRE
ALTER INDEX [ix_estuniv_idejec_filgap_filturno_idcgeneral]  ON universo REBUILD;--91 - SIEMPRE
ALTER INDEX [ix_id_supervfech_reg_ejec_general_id_c_generalIncludes]  ON universo rebuild;--90
ALTER INDEX [ix_estuniv_idcu]  ON universo rebuild;--92
ALTER INDEX [ix_idcu_fechregejecgeneral]  ON universo rebuild;--93
ALTER INDEX [ix_tiprefer_include]  ON universo rebuild;--94
ALTER INDEX [ix__cliente_permite_llamada]  ON universo rebuild;--98
ALTER INDEX [ix__est_univ_id_c_general_cliente_permite_llamada]  ON universo rebuild;--98
ALTER INDEX [iix_id_superv__id_ejec_include]  ON universo rebuild;--108

UPDATE STATISTICS dbo.universo [ix_fech_reg_ejec_general] 
UPDATE STATISTICS dbo.universo [ix_teleuniv1_idsuperv_idejec_idcu] 
UPDATE STATISTICS dbo.universo [PK_Universo]
UPDATE STATISTICS dbo.universo [PK_Universo_id]
UPDATE STATISTICS dbo.universo [ix_teleuniv1_idsuperv_idejec_idcu]
UPDATE STATISTICS dbo.universo [ix_id_c_general_id_ejecIncludes]
UPDATE STATISTICS dbo.universo [ix_estuniv_idejec_filgap_filturno_idcgeneral]
UPDATE STATISTICS dbo.universo [ix_id_supervfech_reg_ejec_general_id_c_generalIncludes]
UPDATE STATISTICS dbo.universo [ix_estuniv_idcu]
UPDATE STATISTICS dbo.universo [ix_fech_reg_ejec] 
UPDATE STATISTICS dbo.universo [ix_idcu_fechregejecgeneral]
UPDATE STATISTICS dbo.universo [ix__cliente_permite_llamada]
UPDATE STATISTICS dbo.universo [ix__est_univ_id_c_general_cliente_permite_llamada]


SELECT COUNT(*) FROM Universo
DBCC SHOW_STATISTICS ('dbo.universo','PK_Universo')
DBCC SHOW_STATISTICS ('dbo.universo','PK_Universo_id')
DBCC SHOW_STATISTICS ('dbo.universo','ix_teleuniv1_idsuperv_idejec_idcu')
DBCC SHOW_STATISTICS ('dbo.universo','ix_fech_reg_ejec')
DBCC SHOW_STATISTICS ('dbo.universo','ix_fech_reg_ejec_general')



------------------------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'buscador_contestadas'


DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.buscador_contestadas'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [PK_buscador_contestadas]  ON buscador_contestadas rebuild;
ALTER INDEX [ix_todos]  ON buscador_contestadas rebuild;
ALTER INDEX [ix_id_cuf_tomadoIncludes]  ON buscador_contestadas rebuild;
UPDATE STATISTICS dbo.buscador_contestadas [ix_todos]
UPDATE STATISTICS dbo.buscador_contestadas [ix_id_cuf_tomadoIncludes]
UPDATE STATISTICS dbo.buscador_contestadas [PK_buscador_contestadas]


DBCC SHOW_STATISTICS ('dbo.buscador_contestadas','PK_buscador_contestadas')
DBCC SHOW_STATISTICS ('dbo.buscador_contestadas','ix_todos')
DBCC SHOW_STATISTICS ('dbo.buscador_contestadas','ix_id_cuf_tomadoIncludes')



--------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'Tb_DetVendedorGestion'

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'Tb_DetVendedorGestion'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [ix_idejec_idgest]  ON Tb_DetVendedorGestion rebuild;
ALTER INDEX [PK_Ttb_DetVendedorGestion]  ON Tb_DetVendedorGestion rebuild;


UPDATE STATISTICS dbo.Tb_DetVendedorGestion PK_Ttb_DetVendedorGestion
UPDATE STATISTICS dbo.Tb_DetVendedorGestion [ix_idejec_idgest]


select  count(*)  from Tb_DetVendedorGestion
DBCC SHOW_STATISTICS ('Tb_DetVendedorGestion','PK_Ttb_DetVendedorGestion')
DBCC SHOW_STATISTICS ('Tb_DetVendedorGestion','ix_idejec_idgest')


--------------------------------------------------------------------------------------------------------------------
exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'llamadaprueba'

UPDATE STATISTICS llamadaprueba PK_llamadaprueba_12 --1
UPDATE STATISTICS llamadaprueba  [ix_idcu] --18
UPDATE STATISTICS llamadaprueba  [ix_fechllamada] --19 
UPDATE STATISTICS llamadaprueba  [ix_fechllamada_idc_idejec] --19 

ALTER INDEX [ix_idcu] ON llamadaprueba rebuild;   -- 18
ALTER INDEX [PK_llamadaprueba_12]  ON llamadaprueba REBUILD; --1
ALTER INDEX [ix_fechllamada]  ON llamadaprueba rebuild; --20
ALTER INDEX [ix_fechllamada_idc_idejec]  ON llamadaprueba REBUILD; --19


select count(*) from llamadaprueba
DBCC SHOW_STATISTICS ('llamadaprueba','PK_llamadaprueba_9')  --1
DBCC SHOW_STATISTICS ('llamadaprueba','ix_idcu')  -- 18
DBCC SHOW_STATISTICS ('llamadaprueba','ix_fechllamada') -- 19
DBCC SHOW_STATISTICS ('llamadaprueba','ix_fechllamada_idc_idejec') -- 19


DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.llamadaPRUEBA'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');



--------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'Llamada'

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.llamada'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

  
ALTER INDEX [PK_Llamada_1]  ON llamada REBUILD;
ALTER INDEX [ix_idc_iduniv_idejec_idcu] ON llamada rebuild;
ALTER INDEX [ix_idejec]  ON llamada REBUILD;
ALTER INDEX [ix_fechllamada]  ON llamada REBUILD;

UPDATE STATISTICS llamada PK_Llamada_1  --1
UPDATE STATISTICS llamada  [ix_idc_iduniv_idejec_idcu] --26
UPDATE STATISTICS llamada  [ix_idejec]  --27
UPDATE STATISTICS llamada  [ix_fechllamada] -- 28


select count(*) from Llamada

DBCC SHOW_STATISTICS ('llamada','PK_Llamada_1') -- 1
DBCC SHOW_STATISTICS ('llamada','ix_idc_iduniv_idejec_idcu') --26
DBCC SHOW_STATISTICS ('llamada','ix_idejec')  --27



-------------------------------------------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'tb_calificativo'

select  count(*)  from Tb_Calificativo

DBCC SHOW_STATISTICS ('Tb_Calificativo','PK_Tb_Calificativo')
DBCC SHOW_STATISTICS ('Tb_Calificativo','ix_idgest_idgestcfam')

UPDATE STATISTICS Tb_Calificativo PK_Tb_Calificativo
UPDATE STATISTICS Tb_Calificativo  [ix_idgest_idgestcfam]

ALTER INDEX [ix_descripcion]  ON tb_calificativo reorganize; -- 18
ALTER INDEX [PK_Tb_Calificativo] ON tb_calificativo rebuild;  --1
ALTER INDEX [ix_nivel1Includes]  ON tb_calificativo REBUILD; ---17
ALTER INDEX [ix_idgest_idgestcfam]  ON tb_calificativo rebuild; ---16


DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.tb_calificativo'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');



----------------------------------------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'producto'


select  count(*)  from producto

DBCC SHOW_STATISTICS ('producto','PK_producto')
DBCC SHOW_STATISTICS ('producto','ix_descripcion')


DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.producto'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [PK_producto] ON producto reorganize;  
ALTER INDEX [ix_descripcion]  ON producto REBUILD;

UPDATE STATISTICS producto PK_producto
UPDATE STATISTICS producto  [ix_descripcion]
----------------------------------------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'supervXemp'

select  count(*)  from supervXemp

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.supervXemp'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [PK_SupervXEmp] ON supervXemp rebuild;   --1
ALTER INDEX [ix_idsuperv_idejec]  ON supervXemp rebuild; --12
ALTER INDEX [estsxe_estse_esteg]  ON supervXemp rebuild; ---13

UPDATE STATISTICS supervXemp [ix_idsuperv_idejec]
UPDATE STATISTICS supervXemp  [PK_SupervXEmp]
UPDATE STATISTICS supervXemp  [ix_idsuperv_idejec]


DBCC SHOW_STATISTICS ('supervXemp','ix_idsuperv_idejec')
DBCC SHOW_STATISTICS ('supervXemp','PK_SupervXEmp')



----------------------------------------------------------------------------------------------
exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'gestion'

select  count(*)  from Gestion

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.gestion'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');


ALTER INDEX [PK_Gestion]  ON dbo.gestion rebuild;
ALTER INDEX [ix_estgest_idgestfam]  ON dbo.gestion rebuild;

UPDATE STATISTICS gestion PK_Gestion

DBCC SHOW_STATISTICS ('gestion','PK_Gestion')
-------------------------------------------------------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'trabajador'


select  count(*)  from Trabajador

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.trabajador'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [PK_Trabajador] ON trabajador reorganize;  
ALTER INDEX [ix_estrab_idtt_idsuperv] ON trabajador rebuild;  
ALTER INDEX [ix_esttrab_idtgest_idtt] ON trabajador rebuild; 
ALTER INDEX [ix_idtrabint] ON trabajador rebuild; 

UPDATE STATISTICS trabajador [ix_estrab_idtt_idsuperv]
UPDATE STATISTICS trabajador [ix_esttrab_idtgest_idtt]
UPDATE STATISTICS trabajador [PK_Trabajador]
UPDATE STATISTICS trabajador [ix_idtrabint]

DBCC SHOW_STATISTICS ('trabajador','ix_estrab_idtt_idsuperv')
DBCC SHOW_STATISTICS ('trabajador','PK_Trabajador')

---------------------------------------------------------------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'tb_familiagestion'

select  count(*)  from Tb_FamiliaGestion

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.tb_familiagestion'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [PK_Trabajador] ON trabajador rebuild;  
ALTER INDEX [ix_estrab_idtt_idsuperv] ON trabajador rebuild;  

UPDATE STATISTICS tb_familiagestion [PK_Tb_FamiliaGestion]
DBCC SHOW_STATISTICS ('tb_familiagestion','PK_Tb_FamiliaGestion')
-----------------------------------------------------------------------------------------------------------------------------

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'tb_telefonosextra'


DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'tb_telefonosextra'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [PK_Tb_TeExtra] ON tb_telefonosextra rebuild;  --1
ALTER INDEX [ix_iduniv_est] ON tb_telefonosextra rebuild;  --10
ALTER INDEX [ix_telefono_estte] ON tb_telefonosextra rebuild;  --9

UPDATE STATISTICS tb_telefonosextra [PK_Tb_TeExtra]
UPDATE STATISTICS tb_telefonosextra [ix_iduniv_est]
UPDATE STATISTICS tb_telefonosextra [ix_telefono_estte]


select  count(*)  from tb_telefonosextra
DBCC SHOW_STATISTICS ('tb_telefonosextra','PK_Tb_TeExtra')
DBCC SHOW_STATISTICS ('tb_telefonosextra','ix_iduniv_est')
DBCC SHOW_STATISTICS ('tb_telefonosextra','ix_telefono_estte')

------------------------------------------------------------------------------------------------------------------------------------

select  *  from DetSupervisorGestion

exec sp_BlitzIndex  @DatabaseName = 'cmyval', @TableName = 'DetSupervisorGestion'

DECLARE @db_id SMALLINT;  
DECLARE @object_id INT;  
SET @db_id = DB_ID();  
SET @object_id = OBJECT_ID(N'dbo.DetSupervisorGestion'); 
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'SAMPLED');

ALTER INDEX [PK_DetSupervisorGestion]   ON DetSupervisorGestion rebuild;
ALTER INDEX [ix_idsuperv]  ON DetSupervisorGestion rebuild;
ALTER INDEX [ix_piso]  ON DetSupervisorGestion rebuild;

UPDATE STATISTICS DetSupervisorGestion [PK_DetSupervisorGestion]
UPDATE STATISTICS DetSupervisorGestion [ix_idsuperv]
UPDATE STATISTICS DetSupervisorGestion [ix_piso]

----------------------------------------------------------------------------------

-- sp_blitzcache @DatabaseName='cmyval', @ExpertMode=1

select getdate(),   
e.physical_memory_kb/1024,--memoria fisica total instalada en el servidor
e.virtual_memory_kb/1024, --cantidad total de memoria virtual disponible para sQL server 
e.committed_kb / 1024 ,--cantidad de memoria asignada por la cache del bufer para el uso por paginas de base de datos
e.committed_target_kb / 1024 -- esta es la cantidad de memoria que la cache del bufer quiere usar. si la 
from sys.dm_os_sys_info e;

32638	134217727	18996	28272
2018-09-15 09:59:10.707	  32638	134217727	21879	28356
2018-09-17 10:56:14.953	32638	134217727	10804	28905
2018-09-17 11:04:12.060	32638	134217727	15568	28905
2018-09-18 11:40:02.747	32638	134217727	18043	28583
2018-09-19 11:02:33.350	32638	134217727	20268	28013
2018-09-20 10:42:33.023	32638	134217727	20500	27697
2018-09-21 10:41:09.633	32638	134217727	20733	27976
2018-09-24 10:30:20.040	32638	134217727	21622	27771
2018-09-27 10:58:10.057	32638	134217727	28500	29305
2018-10-03 10:02:33.433	32638	134217727	12169	28908
2018-10-04 10:11:32.510	32638	134217727	9275	28899

exec sp_WhoIsActive

DBCC FREEPROCCACHE

DBCC FREEPROCCACHE WITH NO_INFOMSGS;

exec sp_WhoIsActive

select 
bd.name , 
COUNT(*) AS buffer_cache_pages,
(count(*) * 8) /1024 as mb_used

from sys.dm_os_buffer_descriptors  bf
inner join sys.databases  bd
on bd.database_id = bf.database_id
where bd.database_id = 11
group by bd.name




USE AdventureWorks2014;
GO
-- New in SQL Server 2016 and SQL Azure
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;


WITH CTE_BUFFER_CACHE AS
( SELECT
  databases.name AS database_name,
  COUNT(*) AS total_number_of_used_pages,
  CAST(COUNT(*) * 8 AS DECIMAL) / 1024 AS buffer_cache_total_MB,
  CAST(CAST(SUM(CAST(dm_os_buffer_descriptors.free_space_in_bytes AS BIGINT)) AS DECIMAL) / (1024 * 1024) AS DECIMAL(20,2))  AS buffer_cache_free_space_in_MB
 FROM sys.dm_os_buffer_descriptors
 INNER JOIN sys.databases
 ON databases.database_id = dm_os_buffer_descriptors.database_id
 where dm_os_buffer_descriptors.database_id = DB_ID()
 GROUP BY databases.name)
SELECT
 *,
 CAST((buffer_cache_free_space_in_MB / NULLIF(buffer_cache_total_MB, 0)) * 100 AS DECIMAL(5,2)) AS buffer_cache_percent_free_space
FROM CTE_BUFFER_CACHE
ORDER BY buffer_cache_free_space_in_MB / NULLIF(buffer_cache_total_MB, 0) DESC




SELECT
	indexes.name AS index_name,
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024  AS buffer_cache_used_MB
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
INNER JOIN sys.indexes
ON objects.object_id = indexes.object_id
AND partitions.index_id = indexes.index_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY indexes.name,
		 objects.name,
		 objects.type_desc
ORDER BY COUNT(*) DESC;




SELECT
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_pages,
	CAST(COUNT(*) * 8 AS DECIMAL) / 1024  AS buffer_cache_total_MB,
	CAST(SUM(CAST(dm_os_buffer_descriptors.free_space_in_bytes AS BIGINT)) AS DECIMAL) / 1024 / 1024 AS buffer_cache_free_space_in_MB,
	CAST((CAST(SUM(CAST(dm_os_buffer_descriptors.free_space_in_bytes AS BIGINT)) AS DECIMAL) / 1024 / 1024) / (CAST(COUNT(*) * 8 AS DECIMAL) / 1024) * 100 AS DECIMAL(5,2)) AS buffer_cache_percent_free_space
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY objects.name,
			objects.type_desc,
			objects.object_id
HAVING COUNT(*) > 0
ORDER BY COUNT(*) DESC;


SELECT top 25
	databases.name,
	dm_exec_sql_text.text AS TSQL_Text,
	CAST(CAST(dm_exec_query_stats.total_worker_time AS DECIMAL)/CAST(dm_exec_query_stats.execution_count AS DECIMAL) AS INT) as cpu_per_execution,
	CAST(CAST(dm_exec_query_stats.total_logical_reads AS DECIMAL)/CAST(dm_exec_query_stats.execution_count AS DECIMAL) AS INT) as logical_reads_per_execution,
	CAST(CAST(dm_exec_query_stats.total_elapsed_time AS DECIMAL)/CAST(dm_exec_query_stats.execution_count AS DECIMAL) AS INT) as elapsed_time_per_execution,
	dm_exec_query_stats.creation_time, 
	dm_exec_query_stats.execution_count,
	dm_exec_query_stats.total_worker_time AS total_cpu_time,
	dm_exec_query_stats.max_worker_time AS max_cpu_time, 
	dm_exec_query_stats.total_elapsed_time, 
	dm_exec_query_stats.max_elapsed_time, 
	dm_exec_query_stats.total_logical_reads, 
	dm_exec_query_stats.max_logical_reads,
	dm_exec_query_stats.total_physical_reads, 
	dm_exec_query_stats.max_physical_reads,
	dm_exec_query_plan.query_plan,
	dm_exec_cached_plans.cacheobjtype,
	dm_exec_cached_plans.objtype,
	dm_exec_cached_plans.size_in_bytes
FROM sys.dm_exec_query_stats 
CROSS APPLY sys.dm_exec_sql_text(dm_exec_query_stats.plan_handle)
CROSS APPLY sys.dm_exec_query_plan(dm_exec_query_stats.plan_handle)
INNER JOIN sys.databases
ON dm_exec_sql_text.dbid = databases.database_id
INNER JOIN sys.dm_exec_cached_plans 
ON dm_exec_cached_plans.plan_handle = dm_exec_query_stats.plan_handle
WHERE databases.name = 'CMYVAL' 
ORDER BY dm_exec_query_stats.max_logical_reads DESC;



SELECT
	AVG(DATEDIFF(HOUR, dm_exec_query_stats.creation_time, CURRENT_TIMESTAMP)) AS average_create_time
FROM sys.dm_exec_query_stats 
CROSS APPLY sys.dm_exec_sql_text(dm_exec_query_stats.plan_handle)
CROSS APPLY sys.dm_exec_query_plan(dm_exec_query_stats.plan_handle)
INNER JOIN sys.databases
ON dm_exec_sql_text.dbid = databases.database_id
WHERE databases.name = 'CMYVAL'


select  *  from Universo

select  id_univ from universo
where id_univ = 'C058447448'


set statistics io on 
select id_univ, fech_reg_ejec from Universo
WHERE fech_reg_ejec BETWEEN CAST('10/08/2018' AS datetime)
                  AND DATEADD(second,-1,DATEADD(day,1,CAST('10/08/2018' AS datetime)))

select id_univ, fech_reg_ejec from Universo
WHERE fech_reg_ejec BETWEEN CAST('20180810' AS datetime)
                  AND DATEADD(second,-1,DATEADD(day,1,CAST('20180810' AS datetime)))