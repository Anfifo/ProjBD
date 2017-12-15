
-- A
/*Qual o nome do fornecedor que forneceu o maior numero de categoria?*/
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



-- B
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


-- C
/*Quais os produtos (ean)  que nunca foram repostos?*/
SELECT ean
	FROM Supermercado.produto
EXCEPT
SELECT ean
	FROM Supermercado.reposicao

-- D
/*Quais os produtos (ean) com um numero de fornecedores secundarios superior a 10?*/
SELECT ean
FROM Supermercado.fornece_sec
GROUP BY ean
HAVING COUNT(nif) > 10;

-- E
/*Quais os produtos (ean) que foram repostos sempre pelo mesmo operador?*/
SELECT ean
FROM Supermercado.reposicao
GROUP BY ean
HAVING COUNT(operador) = 1;

