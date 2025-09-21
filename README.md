# Global-Layoffs-Data-Analysis-MySQL
A data cleaning and EDA project on global layoffs data using MySQL.

This repository showcases a comprehensive data analysis project focusing on global layoffs data. It covers the crucial stages of data cleaning and exploratory data analysis (EDA) using MySQL, demonstrating practical SQL skills for preparing and extracting insights from real-world datasets.

## Project Overview

This project is divided into two main phases:

1.  **Data Cleaning:** Addressing data quality issues to ensure the dataset is accurate, consistent, and ready for analysis.
2.  **Exploratory Data Analysis (EDA):** Discovering patterns, anomalies, and insights within the cleaned data to understand trends in global layoffs.

## Dataset

The dataset used in this project contains information about layoffs from various companies across different industries and countries, spanning from 2020 to early 2023.

## Technologies Used

* **MySQL Workbench:** For database management and SQL query execution.
* **MySQL:** Relational Database Management System.

## Data Cleaning Phase

The data cleaning phase focused on the following key aspects:

* **Duplicate Removal:** Identifying and eliminating redundant entries in the dataset 
* **Data Standardization:** Ensuring consistent formatting and values across critical columns (e.g., `company`, `industry`, `country`).
* **Handling Null & Blank Values:** Populating missing industry information where possible and addressing other null or blank entries .
* **Data Type Conversion:** Changing the `date` column from text to a proper date format for time-series analysis.
* **Irrelevant Data Removal:** Dropping unnecessary columns (e.g., `row_num` ) and rows with insufficient information.

## Exploratory Data Analysis (EDA) Phase

The EDA phase involved querying the cleaned dataset to uncover insights, including:

* **Key Metrics:** Identifying the maximum number of people laid off in a single event and companies with 100% layoffs.
* **Layoffs by Company:** Analyzing which companies had the highest total layoffs.
* **Layoffs by Industry:** Determining industries most affected by layoffs.
* **Layoffs by Country:** Identifying countries with the highest number of layoffs.
* **Time-Series Analysis:**
    * Examining layoffs trends by year.
    * Calculating a rolling total of layoffs per month to observe cumulative impact.
* **Company Layoff Ranking by Year:** Ranking companies based on the number of layoffs per year to highlight annual impact leaders.

## How to Use This Repository

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/Javeriya001/Global-Layoffs-Data-Analysis-MySQL.git
    ```
2.  **Database Setup:**
    * Create a MySQL database (e.g., `world_layoffs`).
    * Import your raw data into a table (e.g., `layoffs_raw`). The raw dataset is typically provided or can be sourced from where the original tutorial links.
3.  **Execute SQL Scripts:**
    * Run the `data_cleaning_mysql.sql` script to transform the raw data into a clean, staging table.
    * Execute the `exploratory_data_analysis_mysql.sql` script to perform the analysis on the cleaned data.

## Relevant YouTube Tutorials

* **Data Cleaning in MySQL | Full Project:** [https://www.youtube.com/watch?v=4UltKCnnnTA](https://www.youtube.com/watch?v=4UltKCnnnTA)
* **MySQL Exploratory Data Analysis | Full Project:** [https://www.youtube.com/watch?v=QYd-RtK58VQ](https://www.youtube.com/watch?v=QYd-RtK58VQ)

## Contact

[Javeriya Tazyeen]
[Tazyeen's LinkedIn Profile](https://www.linkedin.com/in/j-tazyeen-jt25/)
[tazyeenjames@gmail.com]

---
