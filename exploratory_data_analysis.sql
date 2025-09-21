SELECT *
 FROM world_layoff.layoffs_staging2;
 
 SELECT MAX(total_laid_off), MAX(percentage_laid_off)
 FROM world_layoff.layoffs_staging2;
  
  -- 1 is 100 %
  SELECT *
 FROM layoffs_staging2
 WHERE percentage_laid_off = 1
 ORDER BY total_laid_off DESC;
 
 SELECT *
 FROM layoffs_staging2
 WHERE percentage_laid_off = 1
 ORDER BY funds_raised_millions DESC;
 
 SELECT company, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company;

SELECT industry, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY industry
 ORDER BY 2 DESC;
 
 SELECT country, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY country;
 
 SELECT stage, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY stage
 ORDER BY 1 DESC;
 
  SELECT MIN(`date`), MAX(`date`)
 FROM layoffs_staging2;
 
 SELECT YEAR(`date`), SUM(total_laid_off)
 FROM layoffs_staging2
 WHERE YEAR(`date`) IS NOT NULL
 GROUP BY YEAR(`date`)
 ORDER BY YEAR(`date`) DESC;
 
 SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY `MONTH`
 ORDER BY 1 ASC;
 
 WITH Rolling_total AS
 (
 SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
 FROM layoffs_staging2
 WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
 GROUP BY `MONTH`
 ORDER BY 1 ASC
 )
 SELECT `MONTH`, total_off, SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
 FROM Rolling_total;
 
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_year_rank AS
(SELECT *,
 DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_year_rank
WHERE ranking <= 5;

