CREATE SCHEMA IF NOT EXISTS Supermercado;

drop table if exists Supermercado.categoria, Supermercado.fornecedor, Supermercado.produto, Supermercado.corredor,
					 Supermercado.prateleira, Supermercado.planograma, Supermercado.categoria_simples, Supermercado.super_categoria,
					 Supermercado.constituida, Supermercado.fornece_sec, Supermercado.evento_reposicao, Supermercado.reposicao;

drop domain if exists Supermercado.EAN, Supermercado.NIF, Supermercado.NRO, Supermercado.LADO, Supermercado.ALTURA, 
					  Supermercado.CAT_NOME, Supermercado.OPERADOR, Supermercado.INSTANTE;

create domain Supermercado.EAN as numeric(13,0);
create domain Supermercado.NIF as numeric(9,0);
create domain Supermercado.NRO as int;
create domain Supermercado.LADO as varchar(3) check(value in ('esq','dir'));
create domain Supermercado.ALTURA as varchar(8) check(value in ('chao','medio', 'superior'));
create domain Supermercado.CAT_NOME as varchar(100);
create domain Supermercado.OPERADOR as varchar(100);
create domain Supermercado.INSTANTE as timestamp;

create table Supermercado.categoria(
	nome Supermercado.CAT_NOME  not null unique,
	constraint pk_categoria primary key (nome)
);

create table Supermercado.fornecedor(
	nif Supermercado.NIF  not null unique,
	nome varchar(100)  not null,
	constraint pk_fornecedor primary key (nif)
);

create table Supermercado.produto(
	ean Supermercado.EAN  not null unique,
	design varchar(200)  not null,
	categoria Supermercado.CAT_NOME  not null,
	forn_primario Supermercado.NIF  not null,
	data date  not null,
	constraint pk_produto primary key (ean),
	constraint fk_categoria foreign key (categoria) references Supermercado.categoria(nome) on delete cascade,
	constraint fk_forn_primario foreign key (forn_primario) references Supermercado.fornecedor(nif) on delete cascade
);

create table Supermercado.corredor(
	nro Supermercado.NRO not null unique,
	largura numeric(3,2) not null,
	constraint pk_corredor primary key (nro)
);

create table Supermercado.prateleira(
	nro Supermercado.NRO  not null,
	lado Supermercado.LADO not null,
	altura Supermercado.ALTURA not null,
	constraint pk_prateleira primary key(nro,lado,altura),
	constraint fk_nro foreign key (nro) references Supermercado.corredor on delete cascade
);

create table Supermercado.planograma(
	ean Supermercado.EAN not null ,
	nro Supermercado.NRO  not null,
	lado Supermercado.LADO  not null,
	altura Supermercado.ALTURA  not null,
	faces numeric(3,0)  not null,
	unidades numeric(3,0)  not null,
	loc numeric(3,0)  not null,
	constraint pk_planograma primary key(ean, nro, lado, altura),
	constraint fk_ean foreign key(ean) references Supermercado.produto on delete cascade,
	constraint fk_nro_lado_altura foreign key(nro, lado, altura) references Supermercado.prateleira on delete cascade
);


create table Supermercado.categoria_simples(
	nome Supermercado.CAT_NOME not null unique,
	constraint pk_categoria_simples primary key (nome),
	constraint fk_nome foreign key (nome) references Supermercado.categoria on delete cascade
);

create table Supermercado.super_categoria(
	nome Supermercado.CAT_NOME  not null unique,
	constraint pk_super_categoria primary key (nome),
	constraint fk_nome foreign key (nome) references Supermercado.categoria on delete cascade
);

create table Supermercado.constituida(
	super_categoria Supermercado.CAT_NOME  not null,
	categoria Supermercado.CAT_NOME not null,
	constraint fk_super_categoria foreign key (super_categoria) references Supermercado.super_categoria(nome) on delete cascade,
	constraint fk_categoria foreign key (categoria) references Supermercado.categoria(nome) on delete cascade,
	constraint pk_constituida primary key(super_categoria, categoria)
);




create table Supermercado.fornece_sec(
	nif Supermercado.NIF  not null,
	ean Supermercado.EAN  not null,
	constraint pk_fornece_sec primary key (nif, ean),
	constraint fk_ean foreign key (ean) references Supermercado.produto on delete cascade,
	constraint fk_nif foreign key (nif) references Supermercado.fornecedor on delete cascade
);

create table Supermercado.evento_reposicao(
	operador Supermercado.OPERADOR  not null,
	instante Supermercado.INSTANTE not null,
	constraint pk_evento_reposicao primary key (operador, instante)
);

create table Supermercado.reposicao(
	ean Supermercado.EAN not null,
	nro Supermercado.NRO not null,
	lado Supermercado.LADO not null,
	altura Supermercado.ALTURA not null,
	operador Supermercado.OPERADOR not null,
	instante Supermercado.INSTANTE not null,
	unidades int not null,
	constraint pk_reposicao primary key (ean, nro, lado, altura, operador, instante),
	constraint fk_ean_nro_lado_altura foreign key (ean, nro, lado, altura) references Supermercado.planograma on delete cascade,
	constraint fk_operador_instante foreign key (operador, instante) references Supermercado.evento_reposicao on delete cascade
);
