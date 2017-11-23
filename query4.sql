SELECT ean, COUNT(nif)
FROM Supermercado.fornece_sec
GROUP BY ean
HAVING COUNT(nif) > 10;
