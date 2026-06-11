/*
======================================================================================
Stored Procedure: Load Bronze Layer(source -> bronze)
======================================================================================
Script Purpose:
  This stored procedure loads data from external .csv files into 'bronze' schema.
  The files are loaded in the following ways:
  1. Truncate the bronze tables before loading the data
  2. Load the data using 'BULK INSERT' as a command.

Parameters:
None.
This stored procedure does not accept any parameters or return any values.

Command Demo:
EXEC bronze.load_bronze;

*/
=========================================================================================
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY

		PRINT '==================================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '==================================================================';

		PRINT '------------------------------------------------------------------';
		PRINT 'LOADING CRM Tables';
		PRINT '------------------------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncate Table : bronze.crm_cust_info';
	
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data into bronze.crm_cust_info';

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Dyuti Mazumder\Downloads\Dataware house Project\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();

		PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second, @start_time, @end_time) as nvarchar) +	'sec';

		SET @start_time = GETDATE();
		PRINT '>> Truncate Table : bronze.crm_prd_info';

		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data into bronze.crm_prd_info';

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Dyuti Mazumder\Downloads\Dataware house Project\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();

		PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second, @start_time, @end_time) as nvarchar) +	'sec';

		PRINT '>> Truncate Table : bronze.crm_sales_details';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data into bronze.crm_sales_details';

		BULK INSERT bronze.crm_sales_details
    		FROM 'C:\Users\Dyuti Mazumder\Downloads\Dataware house Project\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second, @start_time, @end_time) as nvarchar) +	'sec';

		PRINT '------------------------------------------------------------------';
		PRINT 'LOADING ERP Tables';
		PRINT '------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncate Table : bronze.erp_cust_az12';

		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data into bronze.erp_cust_az12';

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Dyuti Mazumder\Downloads\Dataware house Project\source_erp\cust_az12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second, @start_time, @end_time) as nvarchar) +	'sec';

		PRINT '>> Truncate Table : bronze.erp_loc_a101';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data into bronze.erp_loc_a101';

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Dyuti Mazumder\Downloads\Dataware house Project\source_erp\loc_a101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second, @start_time, @end_time) as nvarchar) +	'sec';

		PRINT '>> Truncate Table : bronze.erp_px_cat_g1v2';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data into bronze.erp_px_cat_g1v2';

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Dyuti Mazumder\Downloads\Dataware house Project\source_erp\px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);

		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION :' + CAST (DATEDIFF(second, @start_time, @end_time) as nvarchar) +	'sec';

	END TRY
	BEGIN CATCH

	PRINT '==================================================';
	PRINT 'ERROR OCCURED DURING LOADING BRONZE TABLE'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT '==================================================';

	END CATCH
END
