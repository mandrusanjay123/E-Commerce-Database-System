
Project Overview
A relational database system development targets the Brazilian E-Commerce Public Dataset by Olist for management purposes and analytical analyses. A relational database system aims to structure and optimize the over 100,000 order data from multiple Brazilian marketplaces spanning between 2016 and 2018.

Steps Involved:
Dataset link : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The Kaggle website provided the dataset in multiple CSV files which contained information about customers, products, orders, payments, reviews and sellers.

The process of data cleaning done in a Jupyter notebook. Database insertion required processing files by treating missing data, duplicate elimination, and data consistency checks before loading the data.

The data loading stage occurred by utilizing a Python script named (load_data_DB.py) to connect with PostgreSQL database where cleaned CSV files filled different table sections.

PostgreSQL database received SQL commands to build tables based on key relationships that supported proper constraints as well as data integrity rules.

The execution of queries needed DML operations (INSERT UPDATE DELETE) that used indexing strategies to achieve better query performance.

The data automation system included stored procedures which executed operations for new customer insertion and product information update. We established upload and download triggers to stop and fix database faults while protecting business data consistency.

SQL transactions serve us to combine several operating steps which either successfully execute together or revert back when encountering failure. Errors during failed transactions got automatically recorded by our implemented trigger system.

Our system achieved better query speed through index optimization of commonly accessed columns along with the use of EXPLAIN ANALYZE for monitoring and quickening slow statements.

Bonus Task: Data Visualization in Tableau

https://public.tableau.com/app/profile/likhitha.k3341/viz/DMQL_phase2_visualisations_dashboard1/Dashboard1

https://public.tableau.com/app/profile/likhitha.k3341/viz/DMQL_phase2_visualisations_dashboard2/Dashboard2?publish=yes

https://public.tableau.com/app/profile/likhitha.k3341/viz/DMQL_phase2_visualisations_dashboard3/Dashboard3?publish=yes



