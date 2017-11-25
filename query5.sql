SELECT ean
FROM Supermercado.reposicao
GROUP BY ean
HAVING COUNT(operador) = 1;
