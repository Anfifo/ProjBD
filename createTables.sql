
/**********************************************************************************
 *								CREATE SCHEMA 									  *
 **********************************************************************************/
CREATE SCHEMA IF NOT EXISTS Supermercado;

/**********************************************************************************
 *								CREATE DOMAINS 									  *
 **********************************************************************************/
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

/**********************************************************************************
 *							PROCEDURES FOR TRIGGERS 						      *
 **********************************************************************************/

 /* RI-EA1: Nao podem existir ciclo super_categoria e categoria (1 nivel)*/
create or replace function ciclos_constituida() returns trigger
as $$
begin
	if exists (select super_categoria, categoria from Supermercado.constituida
		   where super_categoria = new.categoria and categoria = new.super_categoria)
	then
		raise exception 'Nao e possivel criar ciclos em constituida.';
	end if;
	return new;
end
$$ language plpgsql;



/* RI-EA3​ : O instante mais recente de reposicao tem de ser sempre anterior ou igual a data atual */
create or replace function data_anterior_atual() returns trigger
as $$
begin
	if (new.instante > CURRENT_TIMESTAMP)
	then
		raise exception 'O instante de reposicao deve ser anterior ou igual ao atual.';
	end if;
	return new;
end
$$ language plpgsql;



/* RI-EA4: O fornecedor (primario) de um produto nao pode existir na relacao fornece_sec para o mesmo produto */
create or replace function fornecedor_disjoint() returns trigger
as $$
begin
	if exists (select * from Supermercado.produto
				where forn_primario = new.nif and ean = new.ean)
	then
		raise exception 'O fornecedor primario de um produto nao pode ser fornecedor secundario do mesmo produto.';
	end if;
	return new;
end
$$ language plpgsql;


/* RI-RE2: Nome nao pode existir simultaneamente em categoria_simples e em super_categoria */
create or replace function categoria_simples_disjoint() returns trigger
as $$
begin
		if exists (select * from Supermercado.super_categoria where nome = new.nome)
		then
			raise exception 'Uma categoria nao pode ser simultaneamente uma super categoria e uma categoria simples';
		end if;

	return new;
end
$$ language plpgsql;

create or replace function super_categoria_disjoint() returns trigger
as $$
begin
		if exists (select * from Supermercado.categoria_simples where nome = new.nome)
		then
			raise exception 'Uma categoria nao pode ser simultaneamente uma super categoria e uma categoria simples';
		end if;

	return new;
end
$$ language plpgsql;


/**********************************************************************************
 *						      CREATE TABLES 									  *
 **********************************************************************************/
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
	design varchar(200),
	categoria Supermercado.CAT_NOME,
	forn_primario Supermercado.NIF  not null,
	data date  not null default CURRENT_DATE,
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
/* RI-RE2: Nome nao pode existir simultaneamente em categoria_simples e em super_categoria */
create trigger trigger_categoria_simples before insert on Supermercado.categoria_simples
	for each row execute procedure categoria_simples_disjoint();




create table Supermercado.super_categoria(
	nome Supermercado.CAT_NOME  not null unique,
	constraint pk_super_categoria primary key (nome),
	constraint fk_nome foreign key (nome) references Supermercado.categoria on delete cascade
);
/* RI-RE2: Nome nao pode existir simultaneamente em categoria_simples e em super_categoria */
create trigger trigger_super_categoria before insert on Supermercado.super_categoria
	for each row execute procedure super_categoria_disjoint();



create table Supermercado.constituida(
	super_categoria Supermercado.CAT_NOME  not null,
	categoria Supermercado.CAT_NOME not null,
	/*  RI-EA2: super_categoria != categoria_simples */
	constraint super_diff_sub check (super_categoria != categoria),
	constraint fk_super_categoria foreign key (super_categoria) references Supermercado.super_categoria(nome) on delete cascade,
	constraint fk_categoria foreign key (categoria) references Supermercado.categoria(nome) on delete cascade,
	constraint pk_constituida primary key(super_categoria, categoria)
);
/* RI-EA1: Nao podem existir ciclo super_categoria e categoria (1 nivel)*/
create trigger trigger_constituida before insert on Supermercado.constituida
	for each row execute procedure ciclos_constituida();




create table Supermercado.fornece_sec(
	nif Supermercado.NIF  not null,
	ean Supermercado.EAN  not null,
	constraint pk_fornece_sec primary key (nif, ean),
	constraint fk_ean foreign key (ean) references Supermercado.produto on delete cascade,
	constraint fk_nif foreign key (nif) references Supermercado.fornecedor on delete cascade
);
/* RI-EA4: O fornecedor (primario) de um produto nao pode existir na relacao fornece_sec para o mesmo produto */
create trigger trigger_fornece_sec before insert on Supermercado.fornece_sec
	for each row execute procedure fornecedor_disjoint();



create table Supermercado.evento_reposicao(
	operador Supermercado.OPERADOR  not null,
	instante Supermercado.INSTANTE not null,
	constraint pk_evento_reposicao primary key (operador, instante)
);
/* RI-EA3​ : O instante mais recente de reposicao tem de ser sempre anterior ou igual a data atual */
create trigger trigger_evento_reposicao before insert on Supermercado.evento_reposicao
	for each row execute procedure data_anterior_atual();



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

