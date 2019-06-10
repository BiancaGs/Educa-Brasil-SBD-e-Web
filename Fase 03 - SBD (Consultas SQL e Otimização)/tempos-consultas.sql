-- ========================================================
-- Integrantes do Grupo
-- Bianca Gomes Rodrigues	743512
-- Pietro Zuntini Bonfim	743588
-- ========================================================


-- Consulta 1

-- =======================================================
-- 1 - COM JOIN
-- =======================================================

SELECT  e.co_escola, e.nome_escola, e.situacao_funcionamento,
        e.dependencia_adm, e.bercario, e.creche, e.pre_escola,
        e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais,
        e.ens_medio_normal, e.ens_medio_integrado
FROM escola e
JOIN distrito d on e.co_distrito = d.co_distrito
JOIN municipio m on d.co_municipio = m.co_municipio
JOIN microrregiao mi on m.co_microrregiao = mi.co_microrregiao
JOIN mesorregiao me on mi.co_mesorregiao = me.co_mesorregiao
JOIN uf u on me.co_uf = u.co_uf
WHERE u.co_uf = 35
AND m.co_municipio = 3552205
AND e.nome_escola ILIKE '%edu%'
ORDER BY e.qtd_funcionarios;

30 secs 246 msec.
96 rows affected.

"Sort  (cost=12209.24..12209.25 rows=1 width=76) (actual time=526.264..526.271 rows=96 loops=1)"
"  Sort Key: e.qtd_funcionarios"
"  Sort Method: quicksort  Memory: 38kB"
"  ->  Nested Loop  (cost=206.50..12209.23 rows=1 width=76) (actual time=371.788..526.146 rows=96 loops=1)"
"        ->  Nested Loop  (cost=206.50..12207.89 rows=1 width=81) (actual time=371.761..524.926 rows=96 loops=1)"
"              ->  Nested Loop  (cost=0.70..16.81 rows=1 width=11) (actual time=0.025..0.031 rows=1 loops=1)"
"                    ->  Nested Loop  (cost=0.56..16.60 rows=1 width=11) (actual time=0.019..0.022 rows=1 loops=1)"
"                          ->  Index Scan using municipio_pkey on municipio m  (cost=0.28..8.30 rows=1 width=13) (actual time=0.013..0.014 rows=1 loops=1)"
"                                Index Cond: (co_municipio = '3552205'::numeric)"
"                          ->  Index Scan using microrregiao_pkey on microrregiao mi  (cost=0.28..8.29 rows=1 width=12) (actual time=0.003..0.004 rows=1 loops=1)"
"                                Index Cond: (co_microrregiao = m.co_microrregiao)"
"                    ->  Index Scan using mesorregiao_pkey on mesorregiao me  (cost=0.14..0.19 rows=1 width=10) (actual time=0.004..0.006 rows=1 loops=1)"
"                          Index Cond: (co_mesorregiao = mi.co_mesorregiao)"
"                          Filter: (co_uf = '35'::numeric)"
"              ->  Hash Join  (cost=205.80..12191.00 rows=8 width=82) (actual time=371.727..524.859 rows=96 loops=1)"
"                    Hash Cond: (e.co_distrito = d.co_distrito)"
"                    ->  Seq Scan on escola e  (cost=0.00..11836.69 rows=39582 width=85) (actual time=0.094..516.432 rows=30776 loops=1)"
"                          Filter: ((nome_escola)::text ~~* '%edu%'::text)"
"                          Rows Removed by Filter: 255199"
"                    ->  Hash  (cost=205.78..205.78 rows=2 width=15) (actual time=1.994..1.994 rows=1 loops=1)"
"                          Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                          ->  Seq Scan on distrito d  (cost=0.00..205.78 rows=2 width=15) (actual time=1.452..1.977 rows=1 loops=1)"
"                                Filter: (co_municipio = '3552205'::numeric)"
"                                Rows Removed by Filter: 10301"
"        ->  Seq Scan on uf u  (cost=0.00..1.34 rows=1 width=12) (actual time=0.001..0.004 rows=1 loops=96)"
"              Filter: (co_uf = '35'::numeric)"
"              Rows Removed by Filter: 26"
"Planning time: 1.351 ms"
"Execution time: 526.530 ms"


-- =======================================================
-- 2 - COM IN
-- =======================================================

SELECT  e.co_escola, e.nome_escola, e.situacao_funcionamento, 
        e.dependencia_adm, e.bercario, e.creche, e.pre_escola,
        e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais,
        e.ens_medio_normal, e.ens_medio_integrado
FROM escola e
WHERE e.co_distrito IN (
    SELECT d.co_distrito
    FROM distrito d
    WHERE d.co_municipio IN (
        SELECT m.co_municipio
        FROM municipio m
        WHERE m.co_microrregiao IN (
            SELECT mi.co_microrregiao
            FROM microrregiao mi
            WHERE mi.co_mesorregiao IN (
                SELECT me.co_mesorregiao
                FROM mesorregiao me
                WHERE me.co_uf = 35
            )
        )
    )
    AND d.co_municipio = 3552205
)
AND e.nome_escola ILIKE '%edu%'
ORDER BY e.qtd_funcionarios;

19 secs 94 msec.
2 rows affected.

"Sort  (cost=12068.04..12068.04 rows=1 width=76) (actual time=513.862..513.862 rows=2 loops=1)"
"  Sort Key: e.qtd_funcionarios"
"  Sort Method: quicksort  Memory: 25kB"
"  ->  Nested Loop Semi Join  (cost=16.67..12068.03 rows=1 width=76) (actual time=392.434..513.847 rows=2 loops=1)"
"        Join Filter: (e.co_distrito = d.co_distrito)"
"        Rows Removed by Join Filter: 29"
"        ->  Seq Scan on escola e  (cost=0.00..11836.69 rows=28 width=85) (actual time=0.740..511.727 rows=31 loops=1)"
"              Filter: ((nome_escola)::text ~~* '%uirapuru%'::text)"
"              Rows Removed by Filter: 285944"
"        ->  Materialize  (cost=16.67..230.50 rows=2 width=9) (actual time=0.047..0.064 rows=1 loops=31)"
"              ->  Nested Loop Semi Join  (cost=16.67..230.49 rows=2 width=9) (actual time=1.442..1.965 rows=1 loops=1)"
"                    ->  Seq Scan on distrito d  (cost=0.00..205.78 rows=2 width=15) (actual time=1.171..1.693 rows=1 loops=1)"
"                          Filter: (co_municipio = '3552205'::numeric)"
"                          Rows Removed by Filter: 10301"
"                    ->  Materialize  (cost=16.67..24.69 rows=1 width=6) (actual time=0.269..0.269 rows=1 loops=1)"
"                          ->  Hash Semi Join  (cost=16.67..24.69 rows=1 width=6) (actual time=0.264..0.264 rows=1 loops=1)"
"                                Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"                                ->  Index Scan using municipio_pkey on municipio m  (cost=0.28..8.30 rows=1 width=13) (actual time=0.028..0.028 rows=1 loops=1)"
"                                      Index Cond: (co_municipio = '3552205'::numeric)"
"                                ->  Hash  (cost=15.62..15.62 rows=61 width=7) (actual time=0.218..0.218 rows=63 loops=1)"
"                                      Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                                      ->  Hash Semi Join  (cost=3.90..15.62 rows=61 width=7) (actual time=0.112..0.203 rows=63 loops=1)"
"                                            Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                                            ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.004..0.034 rows=558 loops=1)"
"                                            ->  Hash  (cost=3.71..3.71 rows=15 width=5) (actual time=0.065..0.065 rows=15 loops=1)"
"                                                  Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                  ->  Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.022..0.056 rows=15 loops=1)"
"                                                        Filter: (co_uf = '35'::numeric)"
"                                                        Rows Removed by Filter: 122"
"Planning time: 1.952 ms"
"Execution time: 514.239 ms"


-- =======================================================
-- 3 - CRIAÇÃO DO ÍNDICE EM ESCOLA(nome_escola)
-- =======================================================

CREATE INDEX nome_escola_index
ON escola(nome_escola)
2 secs 936 msec.


16 secs 504 msec.
96 rows affected.

"Sort  (cost=12171.45..12171.48 rows=12 width=76) (actual time=498.379..498.387 rows=96 loops=1)"
"  Sort Key: e.qtd_funcionarios"
"  Sort Method: quicksort  Memory: 38kB"
"  ->  Hash Semi Join  (cost=230.52..12171.24 rows=12 width=76) (actual time=356.092..498.304 rows=96 loops=1)"
"        Hash Cond: (e.co_distrito = d.co_distrito)"
"        ->  Seq Scan on escola e  (cost=0.00..11836.69 rows=39582 width=85) (actual time=0.094..490.185 rows=30776 loops=1)"
"              Filter: ((nome_escola)::text ~~* '%edu%'::text)"
"              Rows Removed by Filter: 255199"
"        ->  Hash  (cost=230.49..230.49 rows=2 width=9) (actual time=2.310..2.310 rows=1 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"              ->  Nested Loop Semi Join  (cost=16.67..230.49 rows=2 width=9) (actual time=1.655..2.306 rows=1 loops=1)"
"                    ->  Seq Scan on distrito d  (cost=0.00..205.78 rows=2 width=15) (actual time=1.358..2.009 rows=1 loops=1)"
"                          Filter: (co_municipio = '3552205'::numeric)"
"                          Rows Removed by Filter: 10301"
"                    ->  Materialize  (cost=16.67..24.69 rows=1 width=6) (actual time=0.293..0.293 rows=1 loops=1)"
"                          ->  Hash Semi Join  (cost=16.67..24.69 rows=1 width=6) (actual time=0.248..0.248 rows=1 loops=1)"
"                                Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"                                ->  Index Scan using municipio_pkey on municipio m  (cost=0.28..8.30 rows=1 width=13) (actual time=0.008..0.008 rows=1 loops=1)"
"                                      Index Cond: (co_municipio = '3552205'::numeric)"
"                                ->  Hash  (cost=15.62..15.62 rows=61 width=7) (actual time=0.226..0.226 rows=63 loops=1)"
"                                      Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                                      ->  Hash Semi Join  (cost=3.90..15.62 rows=61 width=7) (actual time=0.069..0.205 rows=63 loops=1)"
"                                            Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                                            ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.004..0.045 rows=558 loops=1)"
"                                            ->  Hash  (cost=3.71..3.71 rows=15 width=5) (actual time=0.040..0.040 rows=15 loops=1)"
"                                                  Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                  ->  Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.009..0.032 rows=15 loops=1)"
"                                                        Filter: (co_uf = '35'::numeric)"
"                                                        Rows Removed by Filter: 122"
"Planning time: 1.180 ms"
"Execution time: 498.556 ms"

-- ! NÃO UTILIZOU O ÍNDICE


-- =======================================================
-- 4 - COM LIKE AO INVÉS DE ILIKE
-- =======================================================

SELECT  e.co_escola, e.nome_escola, e.situacao_funcionamento, 
        e.dependencia_adm, e.bercario, e.creche, e.pre_escola,
        e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais,
        e.ens_medio_normal, e.ens_medio_integrado
FROM escola e
WHERE e.co_distrito IN (
    SELECT d.co_distrito
    FROM distrito d
    WHERE d.co_municipio IN (
        SELECT m.co_municipio
        FROM municipio m
        WHERE m.co_microrregiao IN (
            SELECT mi.co_microrregiao
            FROM microrregiao mi
            WHERE mi.co_mesorregiao IN (
                SELECT me.co_mesorregiao
                FROM mesorregiao me
                WHERE me.co_uf = 35
            )
        )
    )
    AND d.co_municipio = 3552205
)
AND e.nome_escola LIKE '%EDU%'
ORDER BY e.qtd_funcionarios;

2 secs 8 msec.
96 rows affected.


"Sort  (cost=12171.45..12171.48 rows=12 width=76) (actual time=155.081..155.088 rows=96 loops=1)"
"  Sort Key: e.qtd_funcionarios"
"  Sort Method: quicksort  Memory: 38kB"
"  ->  Hash Semi Join  (cost=230.52..12171.24 rows=12 width=76) (actual time=114.982..154.966 rows=96 loops=1)"
"        Hash Cond: (e.co_distrito = d.co_distrito)"
"        ->  Seq Scan on escola e  (cost=0.00..11836.69 rows=39582 width=85) (actual time=0.116..145.545 rows=30776 loops=1)"
"              Filter: ((nome_escola)::text ~~ '%EDU%'::text)"
"              Rows Removed by Filter: 255199"
"        ->  Hash  (cost=230.49..230.49 rows=2 width=9) (actual time=2.824..2.824 rows=1 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"              ->  Nested Loop Semi Join  (cost=16.67..230.49 rows=2 width=9) (actual time=2.325..2.818 rows=1 loops=1)"
"                    ->  Seq Scan on distrito d  (cost=0.00..205.78 rows=2 width=15) (actual time=2.101..2.594 rows=1 loops=1)"
"                          Filter: (co_municipio = '3552205'::numeric)"
"                          Rows Removed by Filter: 10301"
"                    ->  Materialize  (cost=16.67..24.69 rows=1 width=6) (actual time=0.222..0.222 rows=1 loops=1)"
"                          ->  Hash Semi Join  (cost=16.67..24.69 rows=1 width=6) (actual time=0.213..0.213 rows=1 loops=1)"
"                                Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"                                ->  Index Scan using municipio_pkey on municipio m  (cost=0.28..8.30 rows=1 width=13) (actual time=0.013..0.013 rows=1 loops=1)"
"                                      Index Cond: (co_municipio = '3552205'::numeric)"
"                                ->  Hash  (cost=15.62..15.62 rows=61 width=7) (actual time=0.181..0.181 rows=63 loops=1)"
"                                      Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                                      ->  Hash Semi Join  (cost=3.90..15.62 rows=61 width=7) (actual time=0.074..0.168 rows=63 loops=1)"
"                                            Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                                            ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.008..0.040 rows=558 loops=1)"
"                                            ->  Hash  (cost=3.71..3.71 rows=15 width=5) (actual time=0.046..0.046 rows=15 loops=1)"
"                                                  Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                  ->  Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.016..0.034 rows=15 loops=1)"
"                                                        Filter: (co_uf = '35'::numeric)"
"                                                        Rows Removed by Filter: 122"
"Planning time: 1.029 ms"
"Execution time: 155.371 ms"


-- =======================================================
-- 5 - COM MATERIALIZED VIEW
-- =======================================================

-- Criação da VIEW

CREATE MATERIALIZED VIEW distritos<co_uf> AS
SELECT d.co_distrito, d.co_municipio
FROM distrito d
WHERE d.co_municipio IN (
	SELECT m.co_municipio
	FROM municipio m
	WHERE m.co_microrregiao IN (
		SELECT mi.co_microrregiao
		FROM microrregiao mi
		WHERE mi.co_mesorregiao IN (
			SELECT me.co_mesorregiao
			FROM mesorregiao me
			WHERE me.co_uf = <co_uf>
		)
	)
)

-- Nova consulta

SELECT  e.co_escola, e.nome_escola, e.situacao_funcionamento, 
        e.dependencia_adm, e.bercario, e.creche, e.pre_escola,
        e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais,
        e.ens_medio_normal, e.ens_medio_integrado
FROM escola e
WHERE e.co_distrito in (
	SELECT co_distrito
	FROM distritos35 d
	WHERE d.co_municipio = 3552205
)
AND e.nome_escola LIKE '%EDU%'
ORDER BY e.qtd_funcionarios;

1 secs 613 msec.

"Sort  (cost=8434.01..8434.02 rows=3 width=55) (actual time=92.751..92.758 rows=96 loops=1)"
"  Sort Key: e.qtd_funcionarios"
"  Sort Method: quicksort  Memory: 38kB"
"  ->  Hash Semi Join  (cost=20.99..8433.99 rows=3 width=55) (actual time=63.624..92.638 rows=96 loops=1)"
"        Hash Cond: (e.co_distrito = d.co_distrito)"
"        ->  Seq Scan on escola e  (cost=0.00..8360.69 rows=19915 width=64) (actual time=0.036..87.861 rows=30776 loops=1)"
"              Filter: ((nome_escola)::text ~~ '%EDU%'::text)"
"              Rows Removed by Filter: 255199"
"        ->  Hash  (cost=20.98..20.98 rows=1 width=9) (actual time=0.173..0.173 rows=1 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"              ->  Seq Scan on distritos35 d  (cost=0.00..20.98 rows=1 width=9) (actual time=0.160..0.169 rows=1 loops=1)"
"                    Filter: (co_municipio = '3552205'::numeric)"
"                    Rows Removed by Filter: 1037"
"Planning time: 0.368 ms"
"Execution time: 92.920 ms"


-- =======================================================
-- 6 - INDICE EM e.co_distrito
-- =======================================================

CREATE INDEX e_co_distrito_index 
ON escola(co_distrito)
3 secs 607 msec.

SELECT  e.co_escola, e.nome_escola, e.situacao_funcionamento, 
        e.dependencia_adm, e.bercario, e.creche, e.pre_escola,
        e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais,
        e.ens_medio_normal, e.ens_medio_integrado
FROM escola e
WHERE e.co_distrito in (
	SELECT co_distrito
	FROM distritos35 d
	WHERE d.co_municipio = 3552205
)
AND e.nome_escola LIKE '%EDU%'
ORDER BY e.qtd_funcionarios;

482 msec.
96 rows affected.

"Sort  (cost=40.52..40.53 rows=3 width=55) (actual time=0.857..0.868 rows=96 loops=1)"
"  Sort Key: e.qtd_funcionarios"
"  Sort Method: quicksort  Memory: 38kB"
"  ->  Nested Loop  (cost=21.40..40.50 rows=3 width=55) (actual time=0.296..0.784 rows=96 loops=1)"
"        ->  HashAggregate  (cost=20.98..20.99 rows=1 width=9) (actual time=0.254..0.254 rows=1 loops=1)"
"              Group Key: d.co_distrito"
"              ->  Seq Scan on distritos35 d  (cost=0.00..20.98 rows=1 width=9) (actual time=0.231..0.248 rows=1 loops=1)"
"                    Filter: (co_municipio = '3552205'::numeric)"
"                    Rows Removed by Filter: 1037"
"        ->  Index Scan using e_co_distrito_index on escola e  (cost=0.42..19.48 rows=3 width=64) (actual time=0.039..0.474 rows=96 loops=1)"
"              Index Cond: (co_distrito = d.co_distrito)"
"              Filter: ((nome_escola)::text ~~ '%EDU%'::text)"
"              Rows Removed by Filter: 395"
"Planning time: 0.497 ms"
"Execution time: 1.011 ms"


-- =======================================================
-- OBSERVAÇÃO
-- =======================================================

Observamos que na execução da aplicação, a união de ORDER BY com LIMIT/OFFSET era MUITO lenta. Para isso, tivemos que criar um índice em cada view de distritos:

CREATE INDEX distritos<co_uf>_idx_distrito ON distritos<co_uf> (co_distrito)


Consulta otimizada (para depois):

SELECT
	e.co_escola,
	e.nome_escola,
	e.situacao_funcionamento,
	e.dependencia_adm,
	e.bercario,
	e.creche,
	e.pre_escola,
	e.ens_fundamental_anos_iniciais,
	e.ens_fundamental_anos_finais,
	e.ens_medio_normal,
	e.ens_medio_integrado 
FROM
	escola e 
WHERE
	EXISTS (
		SELECT
			1 
		FROM
			distritos35 d 
		WHERE
			(
				e.co_distrito = d.co_distrito
			)
	) 
ORDER BY
	e.co_escola LIMIT 10 OFFSET 0
	

-- Consulta 2

-- =======================================================
-- 1 - COM JOIN
-- =======================================================

SELECT
    GROUPING(e.bercario) g_bercario, GROUPING(e.creche) g_creche, GROUPING(e.pre_escola) g_pe, GROUPING(e.ens_fundamental_anos_iniciais) g_efi,
    GROUPING(e.ens_fundamental_anos_finais) g_efii, GROUPING(e.ens_medio_normal) g_emn,
   	GROUPING(e.ens_medio_integrado) g_emi, GROUPING(e.situacao_funcionamento) g_situacao,
   	GROUPING(e.dependencia_adm) g_dep, GROUPING(e.localizacao) g_localizacao,
	e.bercario, e.creche, e.pre_escola, e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais, e.ens_medio_normal,
	e.ens_medio_integrado,e.situacao_funcionamento, e.dependencia_adm, e.localizacao, count(e.co_escola) as qtd_escolas
FROM escola e
JOIN distrito d on e.co_distrito = d.co_distrito
JOIN municipio m on d.co_municipio = m.co_municipio
JOIN microrregiao m2 on m.co_microrregiao = m2.co_microrregiao
JOIN mesorregiao m3 on m2.co_mesorregiao = m3.co_mesorregiao
JOIN uf u on m3.co_uf = u.co_uf
JOIN regiao r on u.co_regiao = r.co_regiao
WHERE r.co_regiao = 3
GROUP BY GROUPING SETS (
	(e.situacao_funcionamento),
	(e.dependencia_adm),
	(e.localizacao),
	(e.bercario),
	(e.creche),
    (e.pre_escola),
    (e.ens_fundamental_anos_iniciais),
    (e.ens_fundamental_anos_finais),
    (e.ens_medio_normal),
    (e.ens_medio_integrado),
	()
);

31 rows affected.

3 secs 284 msec.
3 secs 334 msec.
6 secs 375 msec.
5 secs 529 msec.
3 secs 553 msec.
3 secs 166 msec.

Média: 4 secs 206 msec.


"GroupAggregate  (cost=2568.31..9738.11 rows=24 width=25) (actual time=136.184..693.832 rows=31 loops=1)"
"  Group Key: e.dependencia_adm"
"  Group Key: ()"
"  Sort Key: e.pre_escola"
"    Group Key: e.pre_escola"
"  Sort Key: e.ens_medio_integrado"
"    Group Key: e.ens_medio_integrado"
"  Sort Key: e.ens_medio_normal"
"    Group Key: e.ens_medio_normal"
"  Sort Key: e.ens_fundamental_anos_finais"
"    Group Key: e.ens_fundamental_anos_finais"
"  Sort Key: e.ens_fundamental_anos_iniciais"
"    Group Key: e.ens_fundamental_anos_iniciais"
"  Sort Key: e.situacao_funcionamento"
"    Group Key: e.situacao_funcionamento"
"  Sort Key: e.creche"
"    Group Key: e.creche"
"  Sort Key: e.bercario"
"    Group Key: e.bercario"
"  Sort Key: e.localizacao"
"    Group Key: e.localizacao"
"  ->  Sort  (cost=2568.31..2594.79 rows=10592 width=25) (actual time=136.099..155.297 rows=90720 loops=1)"
"        Sort Key: e.dependencia_adm"
"        Sort Method: external merge  Disk: 3280kB"
"        ->  Nested Loop  (cost=151.44..1860.20 rows=10592 width=25) (actual time=6.310..81.444 rows=90720 loops=1)"
"              ->  Hash Join  (cost=151.02..373.48 rows=382 width=9) (actual time=6.275..9.064 rows=3248 loops=1)"
"                    Hash Cond: (d.co_municipio = m.co_municipio)"
"                    ->  Seq Scan on distrito d  (cost=0.00..180.02 rows=10302 width=15) (actual time=0.009..1.184 rows=10302 loops=1)"
"                    ->  Hash  (cost=148.44..148.44 rows=206 width=6) (actual time=4.331..4.331 rows=1668 loops=1)"
"                          Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 80kB"
"                          ->  Hash Join  (cost=18.75..148.44 rows=206 width=6) (actual time=1.489..3.651 rows=1668 loops=1)"
"                                Hash Cond: (m.co_microrregiao = m2.co_microrregiao)"
"                                ->  Seq Scan on municipio m  (cost=0.00..106.70 rows=5570 width=13) (actual time=0.011..0.834 rows=5570 loops=1)"
"                                ->  Hash  (cost=18.49..18.49 rows=21 width=7) (actual time=0.615..0.615 rows=160 loops=1)"
"                                      Buckets: 1024  Batches: 1  Memory Usage: 15kB"
"                                      ->  Nested Loop  (cost=5.35..18.49 rows=21 width=7) (actual time=0.301..0.537 rows=160 loops=1)"
"                                            ->  Seq Scan on regiao r  (cost=0.00..1.06 rows=1 width=10) (actual time=0.007..0.009 rows=1 loops=1)"
"                                                  Filter: (co_regiao = '3'::numeric)"
"                                                  Rows Removed by Filter: 4"
"                                            ->  Hash Join  (cost=5.35..17.22 rows=21 width=17) (actual time=0.269..0.478 rows=160 loops=1)"
"                                                  Hash Cond: (m2.co_mesorregiao = m3.co_mesorregiao)"
"                                                  ->  Seq Scan on microrregiao m2  (cost=0.00..9.58 rows=558 width=12) (actual time=0.009..0.080 rows=558 loops=1)"
"                                                  ->  Hash  (cost=5.28..5.28 rows=5 width=15) (actual time=0.152..0.152 rows=37 loops=1)"
"                                                        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                                        ->  Hash Join  (cost=1.35..5.28 rows=5 width=15) (actual time=0.077..0.131 rows=37 loops=1)"
"                                                              Hash Cond: (m3.co_uf = u.co_uf)"
"                                                              ->  Seq Scan on mesorregiao m3  (cost=0.00..3.37 rows=137 width=10) (actual time=0.008..0.021 rows=137 loops=1)"
"                                                              ->  Hash  (cost=1.34..1.34 rows=1 width=22) (actual time=0.026..0.026 rows=4 loops=1)"
"                                                                    Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                                    ->  Seq Scan on uf u  (cost=0.00..1.34 rows=1 width=22) (actual time=0.013..0.017 rows=4 loops=1)"
"                                                                          Filter: (co_regiao = '3'::numeric)"
"                                                                          Rows Removed by Filter: 23"
"              ->  Index Scan using e_co_distrito_index on escola e  (cost=0.42..3.46 rows=43 width=34) (actual time=0.004..0.013 rows=28 loops=3248)"
"                    Index Cond: (co_distrito = d.co_distrito)"
"Planning time: 1.552 ms"
"Execution time: 697.639 ms"


-- =======================================================
-- 2 - COM IN
-- =======================================================

SELECT
    GROUPING(e.bercario) g_bercario, GROUPING(e.creche) g_creche, GROUPING(e.pre_escola) g_pe, GROUPING(e.ens_fundamental_anos_iniciais) g_efi,
    GROUPING(e.ens_fundamental_anos_finais) g_efii, GROUPING(e.ens_medio_normal) g_emn,
   	GROUPING(e.ens_medio_integrado) g_emi, GROUPING(e.situacao_funcionamento) g_situacao,
   	GROUPING(e.dependencia_adm) g_dep, GROUPING(e.localizacao) g_localizacao,
	e.bercario, e.creche, e.pre_escola, e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais, e.ens_medio_normal,
	e.ens_medio_integrado,e.situacao_funcionamento, e.dependencia_adm, e.localizacao, count(e.co_escola) as qtd_escolas
FROM escola e
WHERE e.co_distrito IN (
    SELECT d.co_distrito
	FROM distrito d
	WHERE d.co_municipio IN (
		SELECT m.co_municipio
		FROM municipio m
		WHERE m.co_microrregiao IN (
			SELECT mi.co_microrregiao
			FROM microrregiao mi
			WHERE mi.co_mesorregiao IN (
				SELECT me.co_mesorregiao
				FROM mesorregiao me
				WHERE me.co_uf IN (
					SELECT u.co_uf
					FROM uf u
					WHERE u.co_regiao = 2
				)
			)
		)
	)
)
GROUP BY GROUPING SETS (
	(e.situacao_funcionamento),
	(e.dependencia_adm),
	(e.localizacao),
	(e.bercario),
	(e.creche),
    (e.pre_escola),
    (e.ens_fundamental_anos_iniciais),
    (e.ens_fundamental_anos_finais),
    (e.ens_medio_normal),
    (e.ens_medio_integrado),
	()
);

31 rows affected.

2 secs 335 msec.
2 secs 835 msec.
2 secs 384 msec.
2 secs 178 msec.
2 secs 651 msec.

Média: 2 secs 476 msec.

"GroupAggregate  (cost=2909.37..14102.61 rows=24 width=25) (actual time=166.659..831.167 rows=31 loops=1)"
"  Group Key: e.dependencia_adm"
"  Group Key: ()"
"  Sort Key: e.pre_escola"
"    Group Key: e.pre_escola"
"  Sort Key: e.ens_medio_integrado"
"    Group Key: e.ens_medio_integrado"
"  Sort Key: e.ens_medio_normal"
"    Group Key: e.ens_medio_normal"
"  Sort Key: e.ens_fundamental_anos_finais"
"    Group Key: e.ens_fundamental_anos_finais"
"  Sort Key: e.ens_fundamental_anos_iniciais"
"    Group Key: e.ens_fundamental_anos_iniciais"
"  Sort Key: e.situacao_funcionamento"
"    Group Key: e.situacao_funcionamento"
"  Sort Key: e.creche"
"    Group Key: e.creche"
"  Sort Key: e.bercario"
"    Group Key: e.bercario"
"  Sort Key: e.localizacao"
"    Group Key: e.localizacao"
"  ->  Sort  (cost=2909.37..2949.16 rows=15916 width=25) (actual time=166.572..189.984 rows=111338 loops=1)"
"        Sort Key: e.dependencia_adm"
"        Sort Method: external merge  Disk: 4024kB"
"        ->  Nested Loop  (cost=355.29..1798.58 rows=15916 width=25) (actual time=9.531..100.927 rows=111338 loops=1)"
"              ->  HashAggregate  (cost=354.87..358.57 rows=370 width=9) (actual time=9.511..10.576 rows=3210 loops=1)"
"                    Group Key: d.co_distrito"
"                    ->  Hash Semi Join  (cost=142.76..353.94 rows=370 width=9) (actual time=3.198..7.621 rows=3210 loops=1)"
"                          Hash Cond: (d.co_municipio = m.co_municipio)"
"                          ->  Seq Scan on distrito d  (cost=0.00..180.02 rows=10302 width=15) (actual time=0.005..1.172 rows=10302 loops=1)"
"                          ->  Hash  (cost=140.26..140.26 rows=200 width=6) (actual time=2.991..2.991 rows=1794 loops=1)"
"                                Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 85kB"
"                                ->  Hash Semi Join  (cost=16.72..140.26 rows=200 width=6) (actual time=0.464..2.475 rows=1794 loops=1)"
"                                      Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"                                      ->  Seq Scan on municipio m  (cost=0.00..106.70 rows=5570 width=13) (actual time=0.003..0.529 rows=5570 loops=1)"
"                                      ->  Hash  (cost=16.47..16.47 rows=20 width=7) (actual time=0.448..0.448 rows=188 loops=1)"
"                                            Buckets: 1024  Batches: 1  Memory Usage: 16kB"
"                                            ->  Hash Semi Join  (cost=5.20..16.47 rows=20 width=7) (actual time=0.216..0.396 rows=188 loops=1)"
"                                                  Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                                                  ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.004..0.047 rows=558 loops=1)"
"                                                  ->  Hash  (cost=5.14..5.14 rows=5 width=5) (actual time=0.094..0.094 rows=42 loops=1)"
"                                                        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                                        ->  Hash Semi Join  (cost=1.35..5.14 rows=5 width=5) (actual time=0.036..0.077 rows=42 loops=1)"
"                                                              Hash Cond: (me.co_uf = u.co_uf)"
"                                                              ->  Seq Scan on mesorregiao me  (cost=0.00..3.37 rows=137 width=10) (actual time=0.003..0.013 rows=137 loops=1)"
"                                                              ->  Hash  (cost=1.34..1.34 rows=1 width=12) (actual time=0.018..0.018 rows=9 loops=1)"
"                                                                    Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                                    ->  Seq Scan on uf u  (cost=0.00..1.34 rows=1 width=12) (actual time=0.006..0.011 rows=9 loops=1)"
"                                                                          Filter: (co_regiao = '2'::numeric)"
"                                                                          Rows Removed by Filter: 18"
"              ->  Index Scan using e_co_distrito_index on escola e  (cost=0.42..3.46 rows=43 width=34) (actual time=0.005..0.018 rows=35 loops=3210)"
"                    Index Cond: (co_distrito = d.co_distrito)"
"Planning time: 1.198 ms"
"Execution time: 842.415 ms"


-- =======================================================
-- CRIAÇÃO DA MATERIALIZED VIEW
-- =======================================================

CREATE MATERIALIZED VIEW distritos<co_regiao> AS
SELECT d.co_distrito
FROM distrito d
WHERE d.co_municipio IN (
	SELECT m.co_municipio
	FROM municipio m
	WHERE m.co_microrregiao IN (
		SELECT mi.co_microrregiao
		FROM microrregiao mi
		WHERE mi.co_mesorregiao IN (
			SELECT me.co_mesorregiao
			FROM mesorregiao me
			WHERE me.co_uf IN (
				SELECT u.co_uf
				FROM uf u
				WHERE u.co_regiao = <co_regiao>
			)
		)
	)
);

Consulta:

SELECT
    GROUPING(e.bercario) g_bercario, GROUPING(e.creche) g_creche, GROUPING(e.pre_escola) g_pe, GROUPING(e.ens_fundamental_anos_iniciais) g_efi,
    GROUPING(e.ens_fundamental_anos_finais) g_efii, GROUPING(e.ens_medio_normal) g_emn,
   	GROUPING(e.ens_medio_integrado) g_emi, GROUPING(e.situacao_funcionamento) g_situacao,
   	GROUPING(e.dependencia_adm) g_dep, GROUPING(e.localizacao) g_localizacao,
	e.bercario, e.creche, e.pre_escola, e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais, e.ens_medio_normal,
	e.ens_medio_integrado,e.situacao_funcionamento, e.dependencia_adm, e.localizacao, count(e.co_escola) as qtd_escolas
FROM escola e
WHERE e.co_distrito IN (
    SELECT d.co_distrito
	FROM distritos_regiao3 d
)
GROUP BY GROUPING SETS (
	(e.situacao_funcionamento),
	(e.dependencia_adm),
	(e.localizacao),
	(e.bercario),
	(e.creche),
    (e.pre_escola),
    (e.ens_fundamental_anos_iniciais),
    (e.ens_fundamental_anos_finais),
    (e.ens_medio_normal),
    (e.ens_medio_integrado),
	()
);

1 secs 820 msec.
1 secs 705 msec.
1 secs 524 msec.
1 secs 596 msec.
1 secs 577 msec.

Média: 1 secs 644 msec.

"GroupAggregate  (cost=25335.29..173394.24 rows=24 width=25) (actual time=197.109..747.716 rows=31 loops=1)"
"  Group Key: e.dependencia_adm"
"  Group Key: ()"
"  Sort Key: e.pre_escola"
"    Group Key: e.pre_escola"
"  Sort Key: e.ens_medio_integrado"
"    Group Key: e.ens_medio_integrado"
"  Sort Key: e.ens_medio_normal"
"    Group Key: e.ens_medio_normal"
"  Sort Key: e.ens_fundamental_anos_finais"
"    Group Key: e.ens_fundamental_anos_finais"
"  Sort Key: e.ens_fundamental_anos_iniciais"
"    Group Key: e.ens_fundamental_anos_iniciais"
"  Sort Key: e.situacao_funcionamento"
"    Group Key: e.situacao_funcionamento"
"  Sort Key: e.creche"
"    Group Key: e.creche"
"  Sort Key: e.bercario"
"    Group Key: e.bercario"
"  Sort Key: e.localizacao"
"    Group Key: e.localizacao"
"  ->  Sort  (cost=25335.29..25684.58 rows=139718 width=25) (actual time=197.043..217.315 rows=90720 loops=1)"
"        Sort Key: e.dependencia_adm"
"        Sort Method: external merge  Disk: 3272kB"
"        ->  Hash Semi Join  (cost=98.08..10048.88 rows=139718 width=25) (actual time=9.409..138.985 rows=90720 loops=1)"
"              Hash Cond: (e.co_distrito = d.co_distrito)"
"              ->  Seq Scan on escola e  (cost=0.00..7645.75 rows=285975 width=34) (actual time=0.051..57.113 rows=285975 loops=1)"
"              ->  Hash  (cost=57.48..57.48 rows=3248 width=9) (actual time=0.814..0.814 rows=3248 loops=1)"
"                    Buckets: 4096  Batches: 1  Memory Usage: 163kB"
"                    ->  Seq Scan on distritos_regiao3 d  (cost=0.00..57.48 rows=3248 width=9) (actual time=0.004..0.302 rows=3248 loops=1)"
"Planning time: 0.816 ms"
"Execution time: 752.340 ms"