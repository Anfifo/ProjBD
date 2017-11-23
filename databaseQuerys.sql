/* Inserir e remover categorias e sub-categorias*/
DELETE FROM Supermercado.categoria 
	WHERE nome = 'peixe de rio';

/* Alterar​ ​ a ​ ​ designação​ ​ de​ ​ um​ ​ produto */
UPDATE Supermercado.produto 
	SET design = 'kiwis' 
	WHERE ean = 8245771909701;

/* Listar elentos de reposição de um dado produto, incluindo o número de unidades
   repostas */
SELECT operador, instante, unidades
	FROM Supermercado.reposicao
	WHERE ean = 8245771909701