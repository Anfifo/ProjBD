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
	union
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
