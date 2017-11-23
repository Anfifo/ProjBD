
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