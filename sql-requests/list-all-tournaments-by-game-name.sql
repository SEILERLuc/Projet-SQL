SELECT IdTournament,
       g.Name,
       Date,
       Duration
FROM Tournament
INNER JOIN Game g
    ON g.idGame = tournament.IdGame
