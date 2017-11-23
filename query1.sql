WITH secundarios AS (
	SELECT nif, categoria
	FROM fornece_sec NATURAL JOIN produto
), primarios AS (
	SELECT forn_primario AS nif, categoria FROM produto
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
FROM total_fornecedores NATURAL JOIN fornecedor
GROUP BY nif, nome
HAVING COUNT(DISTINCT categoria) >= ALL (
	SELECT COUNT(DISTINCT categoria)
	FROM total_fornecedores
	GROUP BY nif, nome
);
