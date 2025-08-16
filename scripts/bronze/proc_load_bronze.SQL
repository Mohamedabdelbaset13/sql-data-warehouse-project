/*
=========================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=========================================================
Script purpose:
  This stored procedure loades data into the 'bronze' schema from external CSV files.
  it performs the following actions:
  - Truncates the bronze tables before laoding data.
  - Uses the 'BULK INSERT' command to laod data from csv files to bronze tables.

  Parameters:
    None.
  This  stored procedure does not accept any parameters or return any values.

  Usage Example:
exec bronze.load_bronze
=========================================================


CREATE OR ALTER PROCEDURE bronze.load_bronze AS


BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
BEGIN TRY
	set @batch_start_time= GETDATE ();

		PRINT '==========================================';
		PRINT 'Loading bronze layer';
		PRINT '==========================================';

		PRINT '------------------------------------------';
		PRINT 'loading CRM tables';
		PRINT '------------------------------------------';
		set @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting date into: bronze.crm_cust_info';
		-- The entire BULK INSERT command must be on one logical line.
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\mahdy\Desktop\data warehouse course\sql-data-analytics-project\datasets\csv-files\bronze.crm_cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE ();
		print '>> Load Duration:'+ cast(datediff (second, @start_time, @end_time) as NVARCHAR) + 'Seconds';


		PRINT '>> Truncating Table: bronze.crm_prd_info';
		
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting date into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info FROM 'C:\Users\mahdy\Desktop\data warehouse course\sql-data-analytics-project\datasets\csv-files\bronze.crm_prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE ();
		print '>> Load Duration:'+ cast(datediff (second, @start_time, @end_time) as NVARCHAR) + 'Seconds';


		PRINT '>> Truncating Table: bronze.crm_sales_details';
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting date into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details FROM 'C:\Users\mahdy\Desktop\data warehouse course\sql-data-analytics-project\datasets\csv-files\bronze.crm_sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE ();
		print '>> Load Duration:'+ cast(datediff (second, @start_time, @end_time) as NVARCHAR) + 'Seconds';

		PRINT '------------------------------------------';
		PRINT 'loading ERP tables';
		PRINT '------------------------------------------';

		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting date into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12 FROM 'C:\Users\mahdy\Desktop\data warehouse course\sql-data-analytics-project\datasets\csv-files\bronze.erp_cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE ();
		print '>> Load Duration:'+ cast(datediff (second, @start_time, @end_time) as NVARCHAR) + 'Seconds';


		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		set @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting date into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101 FROM 'C:\Users\mahdy\Desktop\data warehouse course\sql-data-analytics-project\datasets\csv-files\bronze.erp_loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE ();
		print '>> Load Duration:'+ cast(datediff (second, @start_time, @end_time) as NVARCHAR) + 'Seconds';

		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		set @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting date into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2 FROM 'C:\Users\mahdy\Desktop\data warehouse course\sql-data-analytics-project\datasets\csv-files\bronze.erp_px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE ();
		print '>> Load Duration:'+ cast(datediff (second, @start_time, @end_time) as NVARCHAR) + 'Seconds';
	
	set @batch_end_time = GETDATE ();
	PRINT '=======================================';
	PRINT 'Loading bronze layer is Completed';

	print '>> Batch Load Duration:'+ cast(datediff (second, @batch_start_time, @batch_end_time) as NVARCHAR) + 'Seconds';
	PRINT '=======================================';

	END TRY
	BEGIN CATCH
	PRINT '=======================================';
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
	PRINT 'Error meesage' + ERROR_Message ();
	PRINT 'Error meesage' + CAST (ERROR_NUMBER () AS NVARCHAR);
	PRINT 'Error meesage' + CAST (ERROR_STATE () AS NVARCHAR);
	PRINT '=======================================';
	END CATCH
END
