-- Considerando​ ​o​ esquema​ ​em​ ​estrela​ ​criado​ ​em​ ​na​ ​questão​ ​anterior,​ ​escreva​ ​uma​ ​interrogação SQL​ ​OLAP​ ​para​ ​obter​ ​o​ ​número​ ​de​ ​reposições​ ​de​ ​produtos​ ​do​ ​fornecedor​ ​com​ ​NIF​ ​123​​455678​ para​ ​cada​ ​categoria,​ com​ ​rollup​ ​por​ ​ano​ ​e ​mês.​ ​A ​solução​​ apresentada​ poderá​ recorrer​ às instruções​​ ROLLUP,​ ​CUBE,​ ​GROUPING​ ​SETS,​ ou​ à união​ ("UNION")​ ​de​ ​cláusulas​ ​GROUP BY

SELECT categoria, ano, mes, count(cean)
FROM Supermercado.f_reposicao NATURAL JOIN Supermercado.d_tempo NATURAL JOIN Supermercado.d_produto
WHERE nif_fornecedor_principal = 123455678
GROUP BY categoria, ano, mes
UNION
SELECT categoria, ano, null, count(cean)
FROM Supermercado.f_reposicao NATURAL JOIN Supermercado.d_tempo NATURAL JOIN Supermercado.d_produto
WHERE nif_fornecedor_principal = 123455678
GROUP BY categoria, ano
UNION
SELECT categoria, null, null, count(cean)
FROM Supermercado.f_reposicao NATURAL JOIN Supermercado.d_tempo NATURAL JOIN Supermercado.d_produto
WHERE nif_fornecedor_principal = 123455678
GROUP BY categoria
UNION
SELECT null, null, null, count(cean)
FROM Supermercado.f_reposicao NATURAL JOIN Supermercado.d_tempo NATURAL JOIN Supermercado.d_produto
WHERE nif_fornecedor_principal = 123455678
