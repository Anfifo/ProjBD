
-- 1
WITH secundarios AS (
	SELECT nif, categoria
	FROM Supermercado.fornece_sec NATURAL JOIN Supermercado.produto
	GROUP BY nif, categoria
), primarios AS (
	SELECT forn_primario AS nif, categoria FROM Supermercado.produto
	EXCEPT
	SELECT nif, categoria FROM secundarios
), total_fornecedores AS (
	SELECT nif, categoria
	FROM primarios
	UNION
	SELECT nif, categoria
	FROM secundarios
)

SELECT nome
FROM total_fornecedores NATURAL JOIN Supermercado.fornecedor
GROUP BY nif, nome
HAVING COUNT(DISTINCT categoria) >= ALL (
	SELECT COUNT(DISTINCT categoria)
	FROM total_fornecedores
	GROUP BY nif, nome
);



--2
/*Quais os fornecedores primarios (nome e nif) que forneceram produtos de todas
  as categorias simples?*/
SELECT *
FROM Supermercado.fornecedor NATURAL JOIN
(
	SELECT forn_primario AS nif
	FROM Supermercado.produto
	WHERE categoria IN (
		     SELECT nome
		     FROM Supermercado.categoria_simples
	)
	GROUP BY forn_primario
	HAVING COUNT(distinct categoria) = (
			    SELECT COUNT (*)
			    FROM Supermercado.categoria_simples
	)
) AS fornecedor_categoria_simples;


--3
/*Quais os produtos (ean)  que nunca foram repostos?*/
SELECT ean
	FROM Supermercado.produto
EXCEPT
SELECT ean
	FROM Supermercado.reposicao

--4
SELECT ean, COUNT(nif)
FROM Supermercado.fornece_sec
GROUP BY ean
HAVING COUNT(nif) > 10;

--5
SELECT ean
FROM Supermercado.reposicao
GROUP BY ean
HAVING COUNT(operador) = 1;

