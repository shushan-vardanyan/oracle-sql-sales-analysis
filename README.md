# oracle-sql-sales-analysis
Sales, profitability, customer and warehouse analysis using Oracle SQL.


# Sales and Profitability Analysis with Oracle SQL

## Project Overview

This educational project uses Oracle SQL to analyze sales, profitability, customer activity, product performance, and returns.

The project covers 12 analytical tasks. Each task combines SQL queries with an interpretation of the results, follow-up business questions, and recommendations for further investigation.

## Tools and Skills

* **Database:** Oracle Database
* **Environment:** Oracle APEX
* **SQL techniques:** joins, aggregations, subqueries, conditional logic, and window functions
* **Functions:** `NVL`, `NULLIF`, `ROUND`, `TO_CHAR`, `SUBSTR`, and `INSTR`

## Database Structure

The analysis uses five related tables:

| Table                  | Description                                           |
| ---------------------- | ----------------------------------------------------- |
| `P_Warehouses`         | Warehouse information                                 |
| `P_Customers`          | Customer details, addresses, and partner groups       |
| `P_Products`           | Product names, types, and groups                      |
| `P_Transactions`       | Transaction dates, types, customers, and warehouses   |
| `P_TransactionDetails` | Product quantities, prices, sales amounts, and profit |

Each transaction is linked to a customer and a warehouse. Transaction details connect transactions to products.

## Analytical Tasks

1. Calculate total sales for each warehouse, including warehouses with no sales.
2. Identify products with a selling price above AMD 1,000.
3. Compare sales and profit across customer groups.
4. Analyze returns, recorded reasons, and associated sales and profit amounts.
5. Identify the three products with the highest total profit.
6. Evaluate warehouse sales, average profitability, transaction counts, and average transaction amounts.
7. Find sales transactions with a profit margin above 30% and a total amount above AMD 50,000.
8. Identify products whose average selling price exceeds the overall average recorded selling price.
9. Compare retail and wholesale customer groups.
10. Analyze monthly sales and profit.
11. Find each customer's largest sales transaction and its date.
12. Compare customer counts, sales, and profit by city.

## Analytical Approach

The analysis separates observations from possible explanations. Each task addresses:

* What is being analyzed?
* What do the results show?
* What might explain the results?
* What additional information is needed?
* What actions or further analysis could be useful?

The project also considers data quality issues, such as transactions without corresponding detail records.

## Repository Contents

| Path                      | Contents                                                 |
| ------------------------- | -------------------------------------------------------- |
| `sql/`                    | SQL queries organized by analytical task                 |
| `database_structure.docx`       | Original assignment and table descriptions               |
| `analysis.docx` | SQL solutions, findings, and recommendations |
| `README.md`               | Project overview and execution requirements              |

## How to Run

1. Use an Oracle Database environment, such as a workspace accessed through Oracle APEX.
2. Ensure that the five required tables and their data are available in your schema.
3. Open a query from the `SQL/` folder.
4. Run the query using Oracle APEX SQL Workshop or another Oracle-compatible SQL client.

The original tables and data were provided in a learning environment. Database creation scripts and source data are not included in this repository.

Some queries use Armenian text values, including `իրացում` for sales and `վերադարձ` for returns. These values must match the data in the database.

## Assumptions and Limitations

* Most sales analyses include only transactions classified as `իրացում`. Returns are analyzed separately.
* Average recorded profit margin and aggregate profit divided by aggregate sales are different measures and should be interpreted separately.
* Warehouses with no recorded sales may have other operational purposes.
* Findings relate to the supplied educational dataset and should not be generalized to the wider market.
* Possible explanations are hypotheses that require additional evidence.

## Project Purpose

This project demonstrates how SQL can support business analysis by turning transaction data into comparisons, identifying data quality questions, and developing recommendations for further investigation.
