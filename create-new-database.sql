CREATE TABLE Place
(
    IdPlace INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Name VARCHAR2(30),
    Address VARCHAR2(30),
    City VARCHAR2(30)
);

CREATE TABLE Tournament
(
    IdTournament INT PRIMARY KEY NOT NULL,
    IdPlace INT NOT NULL,
    IdGame INT NOT NULL,
    Date VARCHAR2(30) NOT NULL,
    Duration INT,
    FOREIGN KEY (IdPlace) REFERENCES Place(IdPlace),
    FOREIGN KEY (IdGame) REFERENCES Game(IdGame)
);

CREATE TABLE Game
(
    IdGame INT PRIMARY KEY NOT NULL,
    Name VARCHAR2(30)
);

CREATE TABLE Staff
(
    IdStaff INT PRIMARY KEY NOT NULL,
    idEmployeeData INT NOT NULL,
    FOREIGN KEY (idEmployeeData) REFERENCES Employee_Data(idEmployee)
);

CREATE TABLE Player
(
    IdPlayer INT PRIMARY KEY NOT NULL,
    IdGame INT NOT NULL,
    Ranking INT,
    idEmployeeData INT NOT NULL,
    FOREIGN KEY (IdGame) REFERENCES Game(IdGame),
    FOREIGN KEY (idEmployeeData) REFERENCES Employee_Data(idEmployee)
);

CREATE TABLE Coach
(
    IdCoach INT PRIMARY KEY NOT NULL,
    IdGame INT NOT NULL,
    LicenseDate VARCHAR2(30),
    idEmployeeData INT NOT NULL,
    FOREIGN KEY (IdGame) REFERENCES Game(IdGame),
    FOREIGN KEY (idEmployeeData) REFERENCES Employee_Data(idEmployee)
);

CREATE TABLE Employee_Data
(
    IdEmployee INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Lastname VARCHAR2(30),
    Firstname VARCHAR2(30),
    Gender VARCHAR2(30),
    Age INT,
    Wage INT
);
