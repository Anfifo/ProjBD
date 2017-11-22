with secundarios as (
	select nif, categoria
	from fornece_sec natural join produto
), primarios as (
	select forn_primario as nif, categoria from produto
	except
	select nif, categoria from fornece_sec natural join produto
)

select * from secundarios;

