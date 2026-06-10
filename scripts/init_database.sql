/*
CREATE DATABASE AND SCHEMAS 
---------------------------
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
  Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.

*/

-- 1. Create the master project database
Use master;
GO
-- 2. drop and recreate the 'datawarehouse' Database

  IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'datawarehouse')
BEGIN
    ALTER DATABASE datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE datawarehouse;
END;
GO
--3. Create Database 'datawarehouse'  
CREATE DATABASE datawarehouse;

-- 4. Tell SSMS to use this new database for the next steps
USE datawarehouse;

-- 5. Create your Medallion Layer 'folders'

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
