
/*Quais os produtos (ean)  que nunca foram repostos?*/

SELECT ean
	FROM Supermercado.produto
EXCEPT
SELECT ean
	FROM Supermercado.reposicao