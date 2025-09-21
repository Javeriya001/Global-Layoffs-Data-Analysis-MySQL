-- Data Cleaning

SELECT * 
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardized Data
-- 3. Null Values or Blank values
-- 4. Remove any Columns

CREATE TABLE layoffs_raw
LIKE layoffs;

SELECT * 
FROM layoffs_raw;

INSERT layoffs_raw
SELECT *
FROM layoffs;

-- creating a unique id for finding duplicates
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') AS row_num
FROM layoffs_raw;

-- Finding duplicate values
-- we can just ask for SELECT* FROM layoffs_raw WHERE row_num > 1 ; coz , row_num is  a new colum that 
-- does not exits in raw data, so to perform WHERE row_num > 1 we also have to call the query of row_num.
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, 'date',
 stage, country, funds_raised_millions) AS row_num
FROM layoffs_raw
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_raw
WHERE  company = 'Casper';

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, 'date', 
stage, country, funds_raised_millions) AS row_num
FROM layoffs_raw
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;

--  Creating another table to delte the duplicate rows.
CREATE TABLE `layoffs_raw2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_raw2;

INSERT INTO layoffs_raw2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, 'date', 
stage, country, funds_raised_millions) AS row_num
FROM layoffs_raw;

SELECT * 
FROM layoffs_raw2
WHERE row_num > 1;

DELETE
FROM layoffs_raw2
WHERE row_num > 1;

#--2. STANDARDIZING THE DATA
 -- a. removing spaces from COMPANY colum
 SELECT company , TRIM(company)
 FROM layoffs_raw2;

UPDATE layoffs_raw2
SET  company = TRIM(company);

SELECT company 
FROM layoffs_raw2;

-- b. no changes in LOCATION
-- c.merging crypto n crypto currency  - INDUSTRY
SELECT DISTINCT industry
FROM layoffs_raw2;
 
SELECT industry
FROM layoffs_raw2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_raw2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT * 
FROM layoffs_raw2;

-- populaing blank and nulls in INDUSTRY
SELECT *
FROM layoffs_raw2
WHERE industry IS NULL;

UPDATE layoffs_raw2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_raw2;

SELECT *
 FROM layoffs_raw2
 WHERE company LIKE 'Bally%';
 
 # Populating NULLs in INDUSTRY
 SELECT t1.industry, t2.industry
 FROM layoffs_raw2 t1
 JOIN layoffs_raw2 t2
	ON  t1.company = t2.company
    AND t1.location = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;
 
 UPDATE layoffs_raw2 t1
  JOIN layoffs_raw2 t2
	ON  t1.company = t2.company
 SET t1.industry = t2.industry
 WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;
 
 
-- c. Correction in COUNTRY column
SELECT DISTINCT country 
FROM layoffs_raw2;

SELECT *
FROM layoffs_raw2
WHERE country LIKE 'United States.';

SELECT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_raw2
;

UPDATE layoffs_raw2
SET country = 'United States'
WHERE country LIKE 'United States.';

SELECT DISTINCT country 
FROM layoffs_raw2;

-- d. changing DATE from dtype - text to dtype- datetime
SELECT `date`,
STR_TO_DATE( `date`, '%m/%d/%Y')
FROM layoffs_raw2;

UPDATE layoffs_raw2
SET `date` = STR_TO_DATE( `date`, '%m/%d/%Y');

SELECT DISTINCT  industry
FROM layoffs_raw2;

ALTER TABLE  layoffs_raw2
MODIFY COLUMN `date` DATE;

-- 4. NULL values clearing
SELECT *
FROM layoffs_raw2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

DELETE
FROM layoffs_raw2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

-- -5. removing column
ALTER TABLE layoffs_raw2
DROP COLUMN row_num;

SELECT *
FROM layoffs_raw2;
