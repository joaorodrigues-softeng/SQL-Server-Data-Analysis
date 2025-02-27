# SQL Server Data Analysis Project

## Project Overview
This project involves preparing data to design and implement a SQL Server database to store and manage data related to costs, budgets, items, and currency exchange rates.
Additionally, it includes writing SQL queries to extract meaningful insights from the dataset.

## Project Files Description
This Project has the following files:
- **Data.xlsx**: Original excel file with raw data.
- **DataNew.xls**: Transformed data excel to use on SQL.
- **DIAGRAM.jpg**: Image with the SQL Database DIagram.
- **ETL.ipynb**: Jupyter Lab file with the steps made to ETL the raw data.
- **PROJECT_DATA**: SQL Database Backup.
- **PROJECT.sql**: SQL Queries file.

## Dataset Description
The dataset is provided in an Excel file with four sheets:
- **Costs**: Contains information about costs incurred by the company.
- **Budget**: Contains budget allocation data.
- **Items**: Contains details about items.
- **Currency**: Contains currency exchange rates.

## Project Tasks
### 1. ETL
- Extract, Transform and Load data from original Excel File:
  - Create Primary Keys
  - Create Foreign Keys
  - Remove Duplicates
  - Remove NaN
  - Convert data formats to the correct types

### 2. Database Design
- Design a SQL Server database schema with the following tables:
  - `Costs`
  - `Budget`
  - `Items`
  - `Currency`
- Define appropriate **Primary Keys** for each table.
- Establish **Foreign Key** relationships where applicable.
- Choose suitable **data types** for each column.
- Modify the Excel file as needed to ensure proper relational database structure.

### 3. SQL Queries
The project includes writing SQL queries to answer the following analytical questions:
- **Total Costs by Warehouse**: Calculate the total costs (`Amount`) for each warehouse.
- **Budget vs Actual Costs**: Compare the total budget with actual costs for each `Item Key` and `Cost Center`.
- **Currency Conversion**: Convert all costs (`Amount`) to a single currency (e.g., USD) using exchange rates from the `Currency` table.
- **Top 5 Items by Cost**: Identify the top 5 `Item Key` values with the highest total costs.
- **Budget Utilization**: Calculate the percentage of the budget utilized for each `Cost Center`.
- **Monthly Costs**: Display the total costs (`Amount`) for each month.
- **Items Without Budget**: List all `Item Key` values that do not have an allocated budget.
- **Average Currency Rate**: Compute the average currency exchange rate for each currency.
- **Additional Queries**: Other insightful queries can be included to enhance analysis.

## How to Run the Project
1. Install SQL Server and a query execution tool (SQL Server Management Studio or Azure Data Studio).
2. Use the 'PROJECT_DATA' SQL database backup
3. Run the `PROJECT.sql` script to create the database schema and insert sample data.
4. Execute the provided SQL queries to perform data analysis.

## Technologies Used
- Jupyter Lab (for ETL)
- SQL Server
- T-SQL
- Excel (for data preparation)

## Author
João Rodrigues (joaorodrigues.softeng@gmail.com)

## License
This project is open-source and available under the MIT License.

