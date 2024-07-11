-- Data Cleaning

SELECT * 
FROM layoffs;

-- 1 . REMOVE DUPLICATES
-- 2. Standardize The Data
-- 3. NULL Values or blank Values
-- 4. Remove Columns

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT* FROM layoffs;

SELECT *,
row_number() over(partition by company, industry, 
total_laid_off, `date`) as row_num
FROM layoffs_staging;

WITH duplicates_cte as(
SELECT *,
row_number() over(partition by company, location, industry,
total_laid_off, `date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging
)
SELECT *
FROM duplicates_cte
WHERE row_num>1;

SELECT *
FROM layoffs_staging
WHERE company='Oda';

SELECT *
from layoffs_staging
WHERE company='Casper';



CREATE TABLE `layoffs_staging2` (
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
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
row_number() over(partition by company, location, industry,
total_laid_off, `date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num>1;

DELETE 
FROM layoffs_staging2
WHERE row_num>1;

SELECT *
FROM layoffs_staging2;

-- Standardizing Data
SELECT company, Trim(company)
FROM layoffs_staging2;

update layoffs_staging2
SET company=TRIM(company);

SELECT company, Trim(company)
FROM layoffs_staging2;

SELECT  *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%'
ORDER BY 1
;

UPDATE layoffs_staging2
SET industry='Crypto'
Where industry like'Crypto%'
;

SELECT  DISTINCT industry
FROM layoffs_staging2
;

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1
;

SELECT distinct country
FROM layoffs_staging2
WHERE country Like 'United States%'
order by 1
;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country=TRIM(TRAILING '.' FROM country)
WHERE country LIKE '%.';

select date,
str_to_date(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`,'%m/%d/%Y')
;

ALTER TABLE layoffs_staging2
MODIFY column `date` DATE;

-- null blank values
SELECT *
FROM layoffs_staging2
WHERE total_laid_off is null
AND percentage_laid_off is null;

update layoffs_staging2
SET industry=NULL
WHERE industry='';

SELECT DISTINCT industry
FROM layoffs_staging2
where industry is null OR industry ='';	

SELECT *
FROM layoffs_staging2
where industry is null OR industry ='';	

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
    AND t1.location=t2.location
WHERE (t1.industry is NULL) AND
t2.industry is NOT NULL
;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
SET t1.industry=t2.industry
WHERE t1.industry is NULL AND
t2.industry is NOT NULL
;

SELECT *
FROM layoffs_staging2
WHERE industry is NULL
or industry='';

SELECT * 
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off is null
AND percentage_laid_off is null;

-- Deleting the columns and row we don t need
DELETE
FROM layoffs_staging2
WHERE total_laid_off is null
AND percentage_laid_off is null;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off is null
AND percentage_laid_off is null;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

