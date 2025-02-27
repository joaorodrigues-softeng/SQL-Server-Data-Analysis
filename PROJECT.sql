CREATE DATABASE PROJETO

USE PROJETO

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('Items$', 'Currency$', 'Budget$', 'Costs$')
ORDER BY TABLE_NAME, ORDINAL_POSITION;

--a)
SELECT Warehouse, SUM(Amount) AS Total_Cost
FROM Costs$
GROUP BY Warehouse
ORDER BY Total_Cost DESC;

--b)
SELECT 
    b.[% Item Key],
    b.[Cost Center],
    SUM(b.Budget) AS Total_Budget,
    COALESCE(SUM(c.Amount), 0) AS Total_Actual_Costs,
    CASE 
        WHEN SUM(b.Budget) = 0 THEN NULL
        ELSE (COALESCE(SUM(c.Amount), 0) / SUM(b.Budget)) * 100
    END AS Budget_Utilization_Percentage
FROM Budget$ b
LEFT JOIN Costs$ c 
    ON b.[% Item Key] = c.[% Item Key] 
    AND b.[Cost Center] = c.[Cost Center]
GROUP BY b.[% Item Key], b.[Cost Center]
ORDER BY Total_Budget DESC;

--c)
SELECT 
    c.Cos_ID,
    c.Amount,
    c.Currency,
    cur.Currency AS Currency_in_Costs,
    cur.[Currency Rate],
    (TRY_CAST(c.Amount AS FLOAT) * TRY_CAST(cur.[Currency Rate] AS FLOAT)) AS Amount_in_EUR
FROM Costs$ c
JOIN Currency$ cur 
    ON c.Cos_Cur_ID = cur.Cur_ID
WHERE c.Currency <> 'EUR';  -- Somente transações que não estão em EUR

--d)
SELECT TOP 5 c.[% Item Key], SUM(c.Amount) AS Total_Cost
FROM Costs$ c
GROUP BY c.[% Item Key]
ORDER BY Total_Cost DESC;

--e)
SELECT 
    b.[Cost Center],
    SUM(b.Budget) AS Total_Budget,
    COALESCE(SUM(c.Amount), 0) AS Total_Actual_Costs,
    CASE 
        WHEN SUM(b.Budget) = 0 THEN NULL
        ELSE (COALESCE(SUM(c.Amount), 0) / SUM(b.Budget)) * 100
    END AS Budget_Utilization_Percentage
FROM Budget$ b
LEFT JOIN Costs$ c 
    ON b.[Cost Center] = c.[Cost Center]
GROUP BY b.[Cost Center]
ORDER BY Budget_Utilization_Percentage DESC;

--f)
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Amount) AS Total_Cost
FROM Costs$
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

--g)
SELECT DISTINCT c.[% Item Key]
FROM Costs$ c
LEFT JOIN Budget$ b 
    ON c.[% Item Key] = b.[% Item Key]
WHERE b.[% Item Key] IS NULL;

--h)
SELECT Currency, AVG([Currency Rate]) AS Avg_Currency_Rate
FROM Currency$
GROUP BY Currency;

--i) 1. Análise da trend dos custos ao mês (comparar com o mês anterior)
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Amount) AS Total_Cost,
    LAG(SUM(Amount)) OVER (ORDER BY YEAR(Date), MONTH(Date)) AS Prev_Month_Cost,
    (SUM(Amount) - LAG(SUM(Amount)) OVER (ORDER BY YEAR(Date), MONTH(Date))) AS Cost_Change
FROM Costs$
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

--i) 2. Análise da trend dos custos ao ano (comparar com o ano anterior)
SELECT 
    YEAR(Date) AS Year,
    SUM(Amount) AS Total_Cost,
    LAG(SUM(Amount)) OVER (ORDER BY YEAR(Date)) AS Previous_Year_Cost,
    (SUM(Amount) - LAG(SUM(Amount)) OVER (ORDER BY YEAR(Date))) AS Cost_Variation
FROM Costs$
GROUP BY YEAR(Date)
ORDER BY Year;

--i) 3. Análise do custo médio por Center
SELECT 
    [Cost Center],
    AVG(Amount) AS Average_Cost
FROM Costs$
GROUP BY [Cost Center]
ORDER BY Average_Cost DESC;

--i) 4. Custo total por tipo de item
SELECT 
    i.[Item Type],
    SUM(c.Amount) AS Total_Cost
FROM Costs$ c
JOIN Items$ i 
    ON c.[% Item Key] = i.[% Item Key]
GROUP BY i.[Item Type]
ORDER BY Total_Cost DESC;