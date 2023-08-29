SELECT IdTournament,
       P.City,
       P.Address,
       Date,
       Duration
FROM Tournament
INNER JOIN Place P
    ON P.IdPlace = Tournament.IdPlace
