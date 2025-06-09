#----- Exploratory Data Analysis ------------###

SELECT *
FROM world_life_expectancy;

#1. Average, Minimum and Maximum Life Expectancy Per Country
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp,
ROUND(MIN(`Life expectancy`),1) AS Min_Life_Exp,
ROUND(MAX(`Life expectancy`),1) AS Max_Life_Exp,
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`)) AS Life_Increase
FROM world_life_expectancy
GROUP BY Country 
HAVING AVG(`Life expectancy`) <> 0
AND MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase DESC
;

#2. Average Life Expectancy Per Status

SELECT Status, 
ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp
FROM world_life_expectancy
GROUP BY Status;

SELECT Status, COUNT(DISTINCT Country) AS No_of_Countries,
ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp
FROM world_life_expectancy
GROUP BY Status;


#3. Average Life Expectancy and GDP Per Country
SELECT Country, 
ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING GDP > 0
AND Life_Exp > 0
ORDER BY GDP;

#4. Average Life Expectancy and BMI Per Country

SELECT Country, 
ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING BMI > 0
AND Life_Exp > 0
ORDER BY BMI;


SELECT 
SUM(CASE WHEN GDP > 1500 THEN 1 ELSE 0 END) AS High_GDP_count,
AVG(CASE WHEN GDP > 1500 THEN `Life expectancy` ELSE NULL END) AS High_GDP_Life_expectancy,
SUM(CASE WHEN GDP < 1500 THEN 1 ELSE 0 END) AS Low_GDP_count,
AVG(CASE WHEN GDP < 1500 THEN `Life expectancy` ELSE NULL END) AS Low_GDP_Life_expectancy
FROM world_life_expectancy;

SELECT Country, GDP
FROM world_life_expectancy
WHERE GDP > 1500
ORDER BY GDP; 

#5. Rolling the total of Adult Mortality

SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy;
