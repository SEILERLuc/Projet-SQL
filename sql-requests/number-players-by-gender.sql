SELECT Gender, COUNT(IdPlayer) AS 'NbrPlayers'
FROM Player
INNER JOIN Employee_Data ED
    ON ED.IdEmployee = Player.idEmployeeData
GROUP BY Gender;
