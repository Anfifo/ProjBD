with aux as (
select cean, categoria, ano, mes
from Supermercado.f_reposicao R, Supermercado.d_produto P
where nif_fornecedor_primario = 7288326239603
	and R.cean = P.cean
)
select categoria, ano, mes, count(ean)
from aux
group by categoria, ano, mes
union
select categoria, ano, null, count(cean)
from aux
group by categoria,ano
union 
select categoria, null, null, count(cean)
from aux
group by categoria
union
select null, null, null, count(cean)
from aux;