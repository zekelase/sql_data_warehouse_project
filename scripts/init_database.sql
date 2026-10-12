/*
*****************************
Create database and schemas
*****************************
Script purpose:
This script creates a new database named 'Datawarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database 'bronze', 'silver' and 'gold'

WARNING:
Running this script will drop the entire 'datawarehouse' database if it exists.
All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/
use master;
go
-- drop and recreate the 'datawarehouse' database
if exists (select 1 from sys.databases where name = 'datawarehouse')
begin
alter database datawarehouse set single_user with rollback immediate;
drop database datawarehouse;
end;
go
-- create the 'datawarehouse' database
create database datawarehouse;
go

use datawarehouse;
go

create schema bronze;
go

create schema silver;
go

create schema gold;
go
