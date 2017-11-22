drop table if exists categoria, fornecedor, produto, corredor, prateleira, planograma, categoria_simples, super_categoria, constituida,fornece_sec, evento_reposicao, reposicao;
drop domain if exists EAN, NIF, NRO, LADO, ALTURA, CAT_NOME, OPERADOR, INSTANTE;

create domain EAN as numeric(13,0);
create domain NIF as numeric(9,0);
create domain NRO as int;
create domain LADO as varchar(3) check(value in ('esq','dir'));
create domain ALTURA as varchar(8) check(value in ('chao','medio', 'superior'));
create domain CAT_NOME as varchar(100);
create domain OPERADOR as varchar(100);
create domain INSTANTE as timestamp;

create table categoria(
	nome CAT_NOME  not null unique,
	constraint pk_categoria primary key (nome)
);

create table fornecedor(
	nif NIF  not null unique,
	nome varchar(100)  not null,
	constraint pk_fornecedor primary key (nif)
);

create table produto(
	ean EAN  not null unique,
	design varchar(200)  not null,
	categoria CAT_NOME  not null,
	forn_primario NIF  not null,
	data date  not null,
	constraint pk_produto primary key (ean),
	constraint fk_categoria foreign key (categoria) references categoria(nome),
	constraint fk_forn_primario foreign key (forn_primario) references fornecedor(nif)
);

create table corredor(
	nro NRO not null unique,
	largura numeric(3,2) not null,
	constraint pk_corredor primary key (nro)
);

create table prateleira(
	nro NRO  not null,
	lado LADO not null,
	altura ALTURA not null,
	constraint pk_prateleira primary key(nro,lado,altura),
	constraint fk_nro foreign key (nro) references corredor
);

create table planograma(
	ean EAN not null ,
	nro NRO  not null,
	lado LADO  not null,
	altura ALTURA  not null,
	faces numeric(3,0)  not null,
	unidades numeric(3,0)  not null,
	loc numeric(3,0)  not null,
	constraint pk_planograma primary key(ean, nro, lado, altura),
	constraint fk_ean foreign key(ean) references produto,
	constraint fk_nro_lado_altura foreign key(nro, lado, altura) references prateleira
);


create table categoria_simples(
	nome CAT_NOME not null unique,
	constraint pk_categoria_simples primary key (nome),
	constraint fk_nome foreign key (nome) references categoria
);

create table super_categoria(
	nome CAT_NOME  not null unique,
	constraint pk_super_categoria primary key (nome),
	constraint fk_nome foreign key (nome) references categoria
);

create table constituida(
	super_categoria CAT_NOME  not null,
	categoria CAT_NOME not null,
	constraint fk_super_categoria foreign key (super_categoria) references super_categoria(nome),
	constraint fk_categoria foreign key (categoria) references categoria(nome),
	constraint pk_constituida primary key(super_categoria, categoria)
);




create table fornece_sec(
	nif NIF  not null,
	ean EAN  not null,
	constraint pk_fornece_sec primary key (nif, ean),
	constraint fk_ean foreign key (ean) references produto,
	constraint fk_nif foreign key (nif) references fornecedor
);

create table evento_reposicao(
	operador OPERADOR  not null,
	instante INSTANTE not null,
	constraint pk_evento_reposicao primary key (operador, instante)
);

create table reposicao(
	ean EAN not null,
	nro NRO not null,
	lado LADO not null,
	altura ALTURA not null,
	operador OPERADOR not null,
	instante INSTANTE not null,
	unidades int not null,
	constraint pk_reposicao primary key (ean, nro, lado, altura, operador, instante),
	constraint fk_ean_nro_lado_altura foreign key (ean, nro, lado, altura) references planograma,
	constraint fk_operador_instante foreign key (operador, instante) references evento_reposicao
);