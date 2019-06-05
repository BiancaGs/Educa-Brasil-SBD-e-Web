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

Observamos que na execução da aplicação, a união de GROUP BY com LIMIT/OFFSET era MUITO lenta. Para isso, tivemos que criar um índice em cada view de distritos:

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

SELECT count(e.co_escola) as qtd_escolas, (
    	SELECT count(e2.co_escola)
		FROM escola e2
		WHERE e2.dependencia_adm = 'Federal'
	) as qtd_federal, (
	    SELECT count(e3.co_escola)
	    FROM escola e3
	    WHERE e3.dependencia_adm = 'Estadual'
	) as qtd_estadual, (
	    SELECT count(e4.co_escola)
	    FROM escola e4
	    WHERE e4.dependencia_adm = 'Municipal'
	) as qtd_municipal, (
	    SELECT count(e5.co_escola)
	    FROM escola e5
	    WHERE e5.dependencia_adm = 'Privada'
	) as qtd_privada
FROM escola e
JOIN distrito d on e.co_distrito = d.co_distrito
JOIN municipio m on d.co_municipio = m.co_municipio
JOIN microrregiao m2 on m.co_microrregiao = m2.co_microrregiao
JOIN mesorregiao m3 on m2.co_mesorregiao = m3.co_mesorregiao
JOIN uf u on m3.co_uf = u.co_uf
JOIN regiao r on u.co_regiao = r.co_regiao
WHERE r.co_regiao = 3;

2 secs 522 msec.
1 rows affected.


"Aggregate  (cost=60755.66..60755.67 rows=1 width=6) (actual time=548.040..548.040 rows=1 loops=1)"
"  InitPlan 1 (returns $0)"
"    ->  Aggregate  (cost=11838.29..11838.30 rows=1 width=6) (actual time=131.124..131.124 rows=1 loops=1)"
"          ->  Seq Scan on escola e2  (cost=0.00..11836.69 rows=639 width=6) (actual time=0.471..130.623 rows=795 loops=1)"
"                Filter: (dependencia_adm = 'Federal'::dependencia_adm_t)"
"                Rows Removed by Filter: 285180"
"  InitPlan 2 (returns $1)"
"    ->  Aggregate  (cost=11931.61..11931.62 rows=1 width=6) (actual time=81.856..81.856 rows=1 loops=1)"
"          ->  Seq Scan on escola e3  (cost=0.00..11836.69 rows=37968 width=6) (actual time=0.055..79.661 rows=37746 loops=1)"
"                Filter: (dependencia_adm = 'Estadual'::dependencia_adm_t)"
"                Rows Removed by Filter: 248229"
"  InitPlan 3 (returns $2)"
"    ->  Aggregate  (cost=12289.17..12289.18 rows=1 width=6) (actual time=95.282..95.283 rows=1 loops=1)"
"          ->  Seq Scan on escola e4  (cost=0.00..11836.69 rows=180994 width=6) (actual time=0.025..85.757 rows=181459 loops=1)"
"                Filter: (dependencia_adm = 'Municipal'::dependencia_adm_t)"
"                Rows Removed by Filter: 104516"
"  InitPlan 4 (returns $3)"
"    ->  Aggregate  (cost=12002.63..12002.64 rows=1 width=6) (actual time=85.683..85.683 rows=1 loops=1)"
"          ->  Seq Scan on escola e5  (cost=0.00..11836.69 rows=66375 width=6) (actual time=0.028..82.128 rows=65975 loops=1)"
"                Filter: (dependencia_adm = 'Privada'::dependencia_adm_t)"
"                Rows Removed by Filter: 220000"
"  ->  Hash Join  (cost=367.25..12667.45 rows=10592 width=6) (actual time=22.461..149.296 rows=90720 loops=1)"
"        Hash Cond: (e.co_distrito = d.co_distrito)"
"        ->  Seq Scan on escola e  (cost=0.00..11121.75 rows=285975 width=15) (actual time=0.048..76.124 rows=285975 loops=1)"
"        ->  Hash  (cost=362.48..362.48 rows=382 width=9) (actual time=9.882..9.882 rows=3248 loops=1)"
"              Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 163kB"
"              ->  Hash Join  (cost=140.02..362.48 rows=382 width=9) (actual time=5.528..8.763 rows=3248 loops=1)"
"                    Hash Cond: (d.co_municipio = m.co_municipio)"
"                    ->  Seq Scan on distrito d  (cost=0.00..180.02 rows=10302 width=15) (actual time=0.004..1.124 rows=10302 loops=1)"
"                    ->  Hash  (cost=137.44..137.44 rows=206 width=6) (actual time=4.323..4.323 rows=1668 loops=1)"
"                          Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 80kB"
"                          ->  Hash Join  (cost=18.75..137.44 rows=206 width=6) (actual time=1.082..3.451 rows=1668 loops=1)"
"                                Hash Cond: (m.co_microrregiao = m2.co_microrregiao)"
"                                ->  Seq Scan on municipio m  (cost=0.00..95.70 rows=5570 width=13) (actual time=0.004..0.984 rows=5570 loops=1)"
"                                ->  Hash  (cost=18.49..18.49 rows=21 width=7) (actual time=0.412..0.412 rows=160 loops=1)"
"                                      Buckets: 1024  Batches: 1  Memory Usage: 15kB"
"                                      ->  Nested Loop  (cost=5.35..18.49 rows=21 width=7) (actual time=0.156..0.366 rows=160 loops=1)"
"                                            ->  Seq Scan on regiao r  (cost=0.00..1.06 rows=1 width=10) (actual time=0.005..0.006 rows=1 loops=1)"
"                                                  Filter: (co_regiao = '3'::numeric)"
"                                                  Rows Removed by Filter: 4"
"                                            ->  Hash Join  (cost=5.35..17.22 rows=21 width=17) (actual time=0.137..0.326 rows=160 loops=1)"
"                                                  Hash Cond: (m2.co_mesorregiao = m3.co_mesorregiao)"
"                                                  ->  Seq Scan on microrregiao m2  (cost=0.00..9.58 rows=558 width=12) (actual time=0.004..0.055 rows=558 loops=1)"
"                                                  ->  Hash  (cost=5.28..5.28 rows=5 width=15) (actual time=0.108..0.108 rows=37 loops=1)"
"                                                        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                                        ->  Hash Join  (cost=1.35..5.28 rows=5 width=15) (actual time=0.049..0.094 rows=37 loops=1)"
"                                                              Hash Cond: (m3.co_uf = u.co_uf)"
"                                                              ->  Seq Scan on mesorregiao m3  (cost=0.00..3.37 rows=137 width=10) (actual time=0.003..0.015 rows=137 loops=1)"
"                                                              ->  Hash  (cost=1.34..1.34 rows=1 width=22) (actual time=0.020..0.020 rows=4 loops=1)"
"                                                                    Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                                    ->  Seq Scan on uf u  (cost=0.00..1.34 rows=1 width=22) (actual time=0.003..0.009 rows=4 loops=1)"
"                                                                          Filter: (co_regiao = '3'::numeric)"
"                                                                          Rows Removed by Filter: 23"
"Planning time: 2.101 ms"
"Execution time: 548.666 ms"


-- =======================================================
-- 2 - COM IN
-- =======================================================

SELECT count(e.co_escola) as qtd_escolas, (
    	SELECT count(e2.co_escola)
		FROM escola e2
		WHERE e2.dependencia_adm = 'Federal'
	) as qtd_federal, (
	    SELECT count(e3.co_escola)
	    FROM escola e3
	    WHERE e3.dependencia_adm = 'Estadual'
	) as qtd_estadual, (
	    SELECT count(e4.co_escola)
	    FROM escola e4
	    WHERE e4.dependencia_adm = 'Municipal'
	) as qtd_municipal, (
	    SELECT count(e5.co_escola)
	    FROM escola e5
	    WHERE e5.dependencia_adm = 'Privada'
	) as qtd_privada
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
					WHERE u.co_regiao = 3
				)
			)
		)
	)
);

1 secs 679 msec.
1 rows affected.

"Aggregate  (cost=60502.26..60502.27 rows=1 width=6) (actual time=519.606..519.606 rows=1 loops=1)"
"  InitPlan 1 (returns $0)"
"    ->  Aggregate  (cost=11838.29..11838.30 rows=1 width=6) (actual time=87.915..87.915 rows=1 loops=1)"
"          ->  Seq Scan on escola e2  (cost=0.00..11836.69 rows=639 width=6) (actual time=0.367..87.807 rows=795 loops=1)"
"                Filter: (dependencia_adm = 'Federal'::dependencia_adm_t)"
"                Rows Removed by Filter: 285180"
"  InitPlan 2 (returns $1)"
"    ->  Aggregate  (cost=11931.61..11931.62 rows=1 width=6) (actual time=81.427..81.427 rows=1 loops=1)"
"          ->  Seq Scan on escola e3  (cost=0.00..11836.69 rows=37968 width=6) (actual time=0.066..79.491 rows=37746 loops=1)"
"                Filter: (dependencia_adm = 'Estadual'::dependencia_adm_t)"
"                Rows Removed by Filter: 248229"
"  InitPlan 3 (returns $2)"
"    ->  Aggregate  (cost=12289.17..12289.18 rows=1 width=6) (actual time=100.461..100.461 rows=1 loops=1)"
"          ->  Seq Scan on escola e4  (cost=0.00..11836.69 rows=180994 width=6) (actual time=0.023..90.631 rows=181459 loops=1)"
"                Filter: (dependencia_adm = 'Municipal'::dependencia_adm_t)"
"                Rows Removed by Filter: 104516"
"  InitPlan 4 (returns $3)"
"    ->  Aggregate  (cost=12002.63..12002.64 rows=1 width=6) (actual time=96.938..96.938 rows=1 loops=1)"
"          ->  Seq Scan on escola e5  (cost=0.00..11836.69 rows=66375 width=6) (actual time=0.032..92.940 rows=65975 loops=1)"
"                Filter: (dependencia_adm = 'Privada'::dependencia_adm_t)"
"                Rows Removed by Filter: 220000"
"  ->  Hash Semi Join  (cost=347.57..12400.07 rows=16186 width=6) (actual time=23.704..147.957 rows=90720 loops=1)"
"        Hash Cond: (e.co_distrito = d.co_distrito)"
"        ->  Seq Scan on escola e  (cost=0.00..11121.75 rows=285975 width=15) (actual time=0.057..75.152 rows=285975 loops=1)"
"        ->  Hash  (cost=342.94..342.94 rows=370 width=9) (actual time=11.357..11.357 rows=3248 loops=1)"
"              Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 163kB"
"              ->  Hash Semi Join  (cost=131.76..342.94 rows=370 width=9) (actual time=4.884..9.510 rows=3248 loops=1)"
"                    Hash Cond: (d.co_municipio = m.co_municipio)"
"                    ->  Seq Scan on distrito d  (cost=0.00..180.02 rows=10302 width=15) (actual time=0.004..1.634 rows=10302 loops=1)"
"                    ->  Hash  (cost=129.26..129.26 rows=200 width=6) (actual time=3.299..3.299 rows=1668 loops=1)"
"                          Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 80kB"
"                          ->  Hash Semi Join  (cost=16.72..129.26 rows=200 width=6) (actual time=1.148..2.746 rows=1668 loops=1)"
"                                Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"                                ->  Seq Scan on municipio m  (cost=0.00..95.70 rows=5570 width=13) (actual time=0.006..0.622 rows=5570 loops=1)"
"                                ->  Hash  (cost=16.47..16.47 rows=20 width=7) (actual time=0.401..0.401 rows=160 loops=1)"
"                                      Buckets: 1024  Batches: 1  Memory Usage: 15kB"
"                                      ->  Hash Semi Join  (cost=5.20..16.47 rows=20 width=7) (actual time=0.139..0.353 rows=160 loops=1)"
"                                            Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                                            ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.004..0.059 rows=558 loops=1)"
"                                            ->  Hash  (cost=5.14..5.14 rows=5 width=5) (actual time=0.108..0.108 rows=37 loops=1)"
"                                                  Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                                  ->  Hash Semi Join  (cost=1.35..5.14 rows=5 width=5) (actual time=0.045..0.095 rows=37 loops=1)"
"                                                        Hash Cond: (me.co_uf = u.co_uf)"
"                                                        ->  Seq Scan on mesorregiao me  (cost=0.00..3.37 rows=137 width=10) (actual time=0.004..0.017 rows=137 loops=1)"
"                                                        ->  Hash  (cost=1.34..1.34 rows=1 width=12) (actual time=0.021..0.021 rows=4 loops=1)"
"                                                              Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                              ->  Seq Scan on uf u  (cost=0.00..1.34 rows=1 width=12) (actual time=0.006..0.013 rows=4 loops=1)"
"                                                                    Filter: (co_regiao = '3'::numeric)"
"                                                                    Rows Removed by Filter: 23"
"Planning time: 1.754 ms"
"Execution time: 520.121 ms"