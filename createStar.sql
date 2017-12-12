drop table if exists Supermercado.d_produto, Supermercado.d_tempo, Supermercado.f_reposicao;
drop domain if exists Supermercado.CEAN, Supermercado.NIFP, Supermercado.DAY, Supermercado.MONTH, Supermercado.YEAR, Supermercado.CATEGORY, Supermercado.UNITS;

create domain Supermercado.CEAN as numeric(13,0);
create domain Supermercado.NIFP as numeric(9,0);
create domain Supermercado.DAY as numeric(2,0);
create domain Supermercado.MONTH as numeric(2,0);
create domain Supermercado.YEAR as numeric(4,0);
create domain Supermercado.CATEGORY as varchar(100);
create domain Supermercado.UNITS as int;


CREATE TABLE Supermercado.d_produto(
	cean Supermercado.CEAN,
	categoria Supermercado.CATEGORY,
	nif_fornecedor_principal Supermercado.NIF  NOT NULL,
  CONSTRAINT pk_d_produto PRIMARY KEY (cean)
);

CREATE TABLE Supermercado.d_tempo(
  dia Supermercado.DAY,
  mes Supermercado.MONTH,
  ano Supermercado.YEAR,
  CONSTRAINT pk_d_tempo PRIMARY KEY (dia ,mes, ano)
);

CREATE TABLE Supermercado.f_reposicao(
  produto_id Supermercado.CEAN,
  ano_id Supermercado.YEAR,
  mes_id Supermercado.MONTH,
  dia_id Supermercado.DAY,
  unidades Supermercado.UNITS,

  CONSTRAINT pk_f_reposicao PRIMARY KEY (produto_id, ano_id, mes_id, dia_id),
  CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES Supermercado.d_produto(cean) ON DELETE CASCADE,
  CONSTRAINT fk_ano FOREIGN KEY (ano_id, mes_id, dia_id) REFERENCES Supermercado.d_tempo(ano, mes, dia) ON DELETE CASCADE
);


