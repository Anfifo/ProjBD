
insert into Supermercado.categoria values
	('fruta'),
	('legumes'),
	('leguminosas'),
	('tuberculos'),
	('verdura'),
	('peixe'),
	('peixe de rio'),
	('peixe de mar'),
	('carne'),
	('carnes vermelhas'),
	('carnes de aves');

insert into Supermercado.categoria_simples values
	('fruta'),
	('peixe de rio'),
	('peixe de mar'),
	('leguminosas'),
	('verdura'),
	('carnes vermelhas'),
	('carnes de aves');

insert into Supermercado.super_categoria values
	('legumes'),
	('peixe'),
	('carne');

insert into Supermercado.constituida values
	('legumes', 'verdura'),
	('legumes', 'tuberculos'),
	('legumes', 'leguminosas'),
	('carne', 'carnes vermelhas'),
	('carne', 'carnes de aves'),
	('peixe', 'peixe de rio'),
	('peixe', 'peixe de mar');

insert into Supermercado.fornecedor values
	(368661129, 'Desfruta'),
	(352826670, 'MR Frutas'),
	(984879695, 'Padariagate'),
	(526412549, 'Lusobatata'),
	(304155810, 'Amorbio'),
	(477072004,'MF Rural'),
	(623733396, 'Mafripeixe'),
	(994226524, 'Ribapeixe'),
	(453251781, 'Acana'),
	(294736135, 'Gasin'),
	(853983518, 'Sogenave'),
	(878613881, 'Gelpinhos'),
	(607512605, 'Machorro e Filhos');
insert into Supermercado.produto values
	(9806327911116, 'bananas', 'fruta', 368661129, to_date('05 Dec 2000', 'DD Mon YYYY')),
	(3651188857489, 'laranjas', 'fruta', 352826670, to_date('05 Jan 2000', 'DD Mon YYYY')),
	(8871847294232, 'tangerina', 'fruta', 352826670, to_date('05 Mar 2000', 'DD Mon YYYY')),
	(5766270093745, 'macas', 'fruta', 984879695, to_date('05 Apr 2000', 'DD Mon YYYY')),
	(7080453136449, 'ananas', 'fruta', 368661129, to_date('05 Nov 2000', 'DD Mon YYYY')),
	(2759746969561, 'roma', 'fruta', 368661129, to_date('05 Jun 2000', 'DD Mon YYYY')),
	(7590445683570, 'pera', 'fruta', 984879695, to_date('05 Jul 2000', 'DD Mon YYYY')),
	(8245771909701, 'cenoras', 'tuberculos', 526412549, to_date('10 Dec 2000', 'DD Mon YYYY')),
	(2688979678410, 'alfaces', 'verdura', 368661129, to_date('05 Jan 2005', 'DD Mon YYYY')),
	(3728153207168, 'batata', 'tuberculos', 526412549, to_date('10 Dec 2003', 'DD Mon YYYY')),
	(8516636134142, 'feijao', 'leguminosas', 368661129, to_date('15 Dec 2000', 'DD Mon YYYY')),
	(8687798373110, 'grao', 'leguminosas', 477072004, to_date('20 Dec 2004', 'DD Mon YYYY')),
	(6382066059161, 'agriao', 'verdura', 304155810, to_date('12 Mar 2000', 'DD Mon YYYY')),
	(2868529847211, 'couve', 'verdura', 304155810, to_date('7 Dec 2010', 'DD Mon YYYY')),
	(6770541259004, 'pescada', 'peixe de rio', 368661129, to_date('06 Jun 2000', 'DD Mon YYYY')),
	(7690239934178, 'dourada', 'peixe de mar', 368661129, to_date('05 Feb 2000', 'DD Mon YYYY')),
	(5170074158474, 'atum', 'peixe de mar', 994226524, to_date('05 Jul 2009', 'DD Mon YYYY')),
	(2812995729112, 'salmao', 'peixe de rio', 623733396, to_date('03 Nov 2000', 'DD Mon YYYY')),
	(7288326239603, 'bacalhau', 'peixe de mar', 994226524, to_date('21 Dec 2000', 'DD Mon YYYY')),
	(3406026523472, 'almondegas', 'carnes vermelhas', 368661129, to_date('09 Dec 2000', 'DD Mon YYYY')),
	(8040403710884, 'costeletas de porco', 'carnes vermelhas', 453251781, to_date('05 Jan 2003', 'DD Mon YYYY')),
	(7465250659198, 'bifes de peru', 'carnes de aves', 294736135, to_date('05 Dec 2012', 'DD Mon YYYY')),
	(5471671422710, 'frango', 'carnes de aves', 368661129, to_date('05 Dec 2007', 'DD Mon YYYY')),
	(9236111829403, 'hamburguer de vaca', 'carnes vermelhas', 453251781, to_date('16 Dec 2000', 'DD Mon YYYY'));

insert into Supermercado.fornece_sec values
	(352826670, 9806327911116),
	(607512605, 3651188857489),
	(607512605, 8871847294232),
	(352826670, 5766270093745),
	(352826670, 7080453136449),
	(352826670, 2759746969561),
	(352826670, 7590445683570),
	(477072004, 8245771909701),
	(526412549, 2688979678410),
	(477072004, 3728153207168),
	(526412549, 8516636134142),
	(526412549, 8687798373110),
	(477072004, 6382066059161),
	(477072004, 2868529847211),
	(878613881, 6770541259004),
	(878613881, 7690239934178),
	(878613881, 5170074158474),
	(878613881, 2812995729112),
	(878613881, 7288326239603),
	(853983518, 3406026523472),
	(853983518, 8040403710884),
	(853983518, 7465250659198),
	(853983518, 5471671422710),
	(853983518, 9236111829403);

insert into Supermercado.corredor values
	(1, 5.50),
	(2, 5.50),
	(3, 5.50),
	(4, 5.50),
	(5, 5.50),
	(6, 5.50),
	(7, 5.50),
	(8, 5.50);

insert into Supermercado.prateleira values
	(1, 'esq', 'chao'),
	(2, 'dir', 'chao'),
	(3, 'esq', 'medio'),
	(4, 'dir', 'medio'),
	(5, 'esq', 'superior'),
	(6, 'dir', 'superior'),
	(7, 'esq', 'superior'),
	(8, 'dir', 'medio'),
	(1, 'dir', 'chao'),
	(2, 'esq', 'chao'),
	(3, 'dir', 'medio'),
	(4, 'esq', 'medio'),
	(5, 'dir', 'superior'),
	(6, 'esq', 'superior'),
	(7, 'dir', 'superior'),
	(8, 'esq', 'medio');


insert into Supermercado.planograma values
	(9806327911116, 1, 'esq', 'chao', 10, 30, 5),
	(3651188857489, 1, 'dir', 'chao', 10, 30, 5),
	(8871847294232, 2, 'esq', 'chao', 10, 30, 5),
	(5766270093745, 2, 'dir', 'chao', 10, 30, 5),
	(7080453136449, 3, 'esq', 'medio', 10, 30, 5),
	(2759746969561, 3, 'dir', 'medio', 10, 30, 5),
	(7590445683570, 4, 'esq', 'medio', 10, 30, 5),
	(8245771909701, 4, 'dir', 'medio', 10, 30, 5),
	(2688979678410, 5, 'esq', 'superior', 10, 30, 5),
	(3728153207168, 5, 'dir', 'superior', 10, 30, 5),
	(8516636134142, 6, 'esq', 'superior', 10, 30, 5),
	(8687798373110, 6, 'dir', 'superior', 10, 30, 5),
	(6382066059161, 7, 'esq', 'superior', 10, 30, 5),
	(2868529847211, 7, 'dir', 'superior', 10, 30, 5),
	(6770541259004, 8, 'esq', 'medio', 10, 30, 5),
	(7690239934178, 8, 'dir', 'medio', 10, 30, 5),
	(5170074158474, 1, 'esq', 'chao', 10, 30, 6),
	(2812995729112, 2, 'dir', 'chao', 10, 30, 6),
	(7288326239603, 3, 'esq', 'medio', 10, 30, 6),
	(3406026523472, 4, 'dir', 'medio', 10, 30, 6),
	(8040403710884, 5, 'esq', 'superior', 10, 30, 6),
	(7465250659198, 6, 'dir', 'superior', 10, 30, 6),
	(5471671422710, 7, 'esq', 'superior', 10, 30, 6),
	(9236111829403, 8, 'dir', 'medio', 10, 30, 6);

insert into Supermercado.evento_reposicao values
	('José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS')),
	('Rodolfo', to_timestamp('2012-11-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS')),
	('Rodolfo', to_timestamp('2012-12-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS')),
	('Maria', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS')),
	('Maria', to_timestamp('2011-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS')),
	('Genoveva', to_timestamp('2008-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS')),
	('Genoveva', to_timestamp('2007-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS')),
	('Genoveva', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'));

		
insert into Supermercado.reposicao values
	(9806327911116, 1, 'esq', 'chao', 'José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(8871847294232, 2, 'esq', 'chao', 'Maria', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(5766270093745, 2, 'dir', 'chao', 'Maria', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(2759746969561, 3, 'dir', 'medio', 'Maria', to_timestamp('2011-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(8245771909701, 4, 'dir', 'medio', 'José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(2688979678410, 5, 'esq', 'superior', 'José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(3728153207168, 5, 'dir', 'superior', 'José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(8687798373110, 6, 'dir', 'superior', 'Rodolfo', to_timestamp('2012-12-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(6382066059161, 7, 'esq', 'superior', 'Rodolfo', to_timestamp('2012-12-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(6770541259004, 8, 'esq', 'medio', 'Rodolfo', to_timestamp('2012-11-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(7690239934178, 8, 'dir', 'medio', 'José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(2812995729112, 2, 'dir', 'chao', 'José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(7288326239603, 3, 'esq', 'medio', 'José', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(8040403710884, 5, 'esq', 'superior', 'Genoveva', to_timestamp('2007-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(7465250659198, 6, 'dir', 'superior', 'Genoveva', to_timestamp('2008-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3),
	(5471671422710, 7, 'esq', 'superior', 'Genoveva', to_timestamp('2012-10-09 1:10:21 CST','YYYY-MM-DD HH24:MI:SS'), 3);