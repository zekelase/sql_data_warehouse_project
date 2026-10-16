/*
==============================
procedure loads bronze layer (source -> bronze)
==============================
script purpose;
  this procedure loads data into the bronze schema from external .csv files
  it performs the following actions:
      - truncates the bronze tables before loading data
      - uses the 'bulk insert' command to load data from .csv files into bronze tables
no parameters 
  this procedure does not accept any parameters or returns any values

The procedure is then executed using exec bronze.load_bronze;
============================================================
*/

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @bronze_begin datetime, @bronze_end datetime
	begin try
	set @bronze_begin = getdate()
	print '=============================';
	print 'Loading Bronze Layer';
	print '=============================';

	print '-----------------------------';
	print 'Loading CRM Tables';
	print '-----------------------------';

	print '>> Truncating Table: bronze.crm_sales_details'
	set @start_time = getdate()
truncate table bronze.crm_sales_details;
	print '>> Inserting data into table: bronze.crm_sales_details'
bulk insert bronze.crm_sales_details
from 'C:\Users\Admin\Videos\Coding Videos\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
	set @end_time = getdate();
	print 'load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

	print '>> Truncating Table: bronze.crm_prd_info'
	set @start_time = getdate()

	truncate table bronze.crm_prd_info;
print '>> Inserting data into table: bronze.crm_prd_info'
	bulk insert bronze.crm_prd_info
from 'C:\Users\Admin\Videos\Coding Videos\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);

set @end_time = getdate()
print 'load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'


	print '>> Truncating Table: bronze.crm_cust_info'
	set @start_time = getdate()
truncate table bronze.crm_cust_info;
	print '>> Inserting data into table: bronze.crm_cust_info'
bulk insert bronze.crm_cust_info
from 'C:\Users\Admin\Videos\Coding Videos\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate()
print 'load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

	print '--------------------------'
	print 'Loading erp tables'
	print '--------------------------'

	print '>> Truncating Table: bronze.erp_CUST_AZ12'
	set @start_time = getdate()
truncate table bronze.erp_CUST_AZ12;
	print '>> Inserting data into table: bronze.erp_CUST_AZ12'
bulk insert bronze.erp_CUST_AZ12
from 'C:\Users\Admin\Videos\Coding Videos\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate()
print 'load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

	print '>> Truncating Table: bronze.erp_LOC_A101'
	set @start_time = getdate()
truncate table bronze.erp_LOC_A101;
	print '>> Inserting data into table: bronze.erp_LOC_A101'
bulk insert bronze.erp_LOC_A101
from 'C:\Users\Admin\Videos\Coding Videos\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate()
print 'load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

	print '>> Truncating Table: bronze.erp_PX_CAT_G1V2'
	set @start_time = getdate()
truncate table bronze.erp_PX_CAT_G1V2;
	print '>> Inserting data into table: bronze.erp_PX_CAT_G1V2'
bulk insert bronze.erp_PX_CAT_G1V2
from 'C:\Users\Admin\Videos\Coding Videos\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate()
print 'load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
print '--------------------------------------------'
set @bronze_end = getdate()

print 'total duration of bronze layer: ' + cast(datediff(second, @bronze_begin, @bronze_end) as nvarchar) + ' seconds'
	end try
	begin catch
	print '==============================='
	print 'ERROR OCCURRED WHILE LOADING INTO BRONZE LAYER';
	PRINT 'ERROR ' + ERROR_MESSAGE();
	PRINT 'ERROR ' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR ' + CAST(ERROR_STATE() AS NVARCHAR)
	print '==============================='
	end catch
end
go
exec bronze.load_bronze
