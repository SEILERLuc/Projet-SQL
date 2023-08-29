SELECT Name, AVG(Wage) AS 'AverageWage'
FROM Employee_Data
INNER JOIN Player P
    ON Employee_Data.IdEmployee = P.idEmployeeData
INNER JOIN Game G
    ON G.IdGame = P.IdGame
GROUP BY Name