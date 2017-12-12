

INSERT INTO Supermercado.d_produto (cean, categoria, nif_fornecedor_principal)
SELECT ean, categoria, forn_primario
FROM Supermercado.produto;

INSERT INTO Supermercado.d_tempo (dia, mes, ano)
SELECT DISTINCT EXTRACT(DAY FROM instante),
  EXTRACT(MONTH FROM instante),
  EXTRACT(YEAR FROM instante)
FROM Supermercado.reposicao;

INSERT INTO Supermercado.f_reposicao( produto_id, ano_id, mes_id, dia_id, unidades)
SELECT ean,
  EXTRACT(YEAR FROM instante),
  EXTRACT(MONTH FROM instante),
  EXTRACT(DAY FROM instante),
  unidades
FROM Supermercado.reposicao;