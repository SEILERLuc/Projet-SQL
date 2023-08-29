ATTACH DATABASE 'C:\Users\lucky\Ynov\Projets\Project_SQL\tpb2.db' AS old;

/*MIGRATE GAME TABLE*/
INSERT OR IGNORE INTO Game(IdGame, Name)
SELECT IdGame, Name
FROM old.game;

/*MIGRATE PLAGE TABLE*/
INSERT OR IGNORE INTO Place (Name, Address, City)
SELECT PlaceName, Address, City
FROM old.tournament
GROUP BY Address;

/*MIGRATION TOURNAMENT TABLE*/
INSERT OR IGNORE INTO Tournament
    (
     IdTournament,
     IdPlace,
     IdGame,
     Date,
     Duration
     )
SELECT IdTournament, IdPlace, IdGame, Date, Duration
FROM old.tournament
INNER JOIN Place p
ON p.Name = old.tournament.PlaceName;

/*MIGRATION FROM PLAYER TO EMPOYEE*/
INSERT OR IGNORE INTO Employee_Data
    (
     Lastname,
     Firstname,
     Gender,
     Age,
     Wage
     )
SELECT DISTINCT Lastname, Firstname, Gender, Age, Wage
FROM old.Player
GROUP BY Lastname, Firstname, Gender, Age, Wage;

/*MIGRATION FROM COACH TO EMPLOYEE*/
INSERT OR IGNORE INTO Employee_Data
    (
     Lastname,
     Firstname,
     Gender,
     Age,
     Wage
     )
SELECT Lastname, Firstname, Gender, Age, Wage
FROM old.Coach
GROUP BY Lastname, Firstname, Gender, Age, Wage;

/*MIGRATION FROM STAFF TO EMPLOYEE*/
INSERT OR IGNORE INTO Employee_Data
    (
     Lastname,
     Firstname,
     Gender,
     Age,
     Wage
     )
SELECT Lastname, Firstname, Gender, Age, Wage
FROM old.Staff
GROUP BY Lastname, Firstname, Gender, Age, Wage;

/*MIGRATION FOR STAFF TABLE*/
INSERT OR IGNORE INTO Staff (IdStaff, idEmployeeData)
SELECT DISTINCT IdStaff, IdEmployee
FROM old.Staff, Employee_Data
WHERE old.Staff.Lastname = Employee_Data.Lastname AND
      old.Staff.Firstname = Employee_Data.Firstname AND
      old.Staff.Age = Employee_Data.Age
GROUP BY IdStaff, IdEmployee;

/*MIGRATION FOR PLAYER TABLE*/
INSERT OR IGNORE INTO Player
    (
     IdPlayer,
     IdGame,
     Ranking,
     idEmployeeData
     )
SELECT IdPlayer, IdGame, Ranking, IdEmployee
FROM old.Player, Employee_Data
WHERE old.Player.Lastname = Employee_Data.Lastname AND
      old.Player.Firstname = Employee_Data.Firstname AND
      old.Player.Age = Employee_Data.Age
GROUP BY IdPlayer;

/*MIGRATION FOR COACH TABLE*/
INSERT OR IGNORE INTO Coach
    (
     IdCoach,
     IdGame,
     LicenseDate,
     idEmployeeData
     )
SELECT IdCoach,
       IdGame,
       LicenseDate,
       IdEmployee
FROM old.Coach, Employee_Data
WHERE old.Coach.Lastname = Employee_Data.Lastname AND
      old.Coach.Firstname = Employee_Data.Firstname AND
      old.Coach.Age = Employee_Data.Age
GROUP BY IdCoach;