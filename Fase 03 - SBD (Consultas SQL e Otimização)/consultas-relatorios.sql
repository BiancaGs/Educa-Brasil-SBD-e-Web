SELECT e.situacao_funcionamento, e.dependencia_adm, e.localizacao, count(e.co_escola) as qtd_escolas
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
)
GROUP BY GROUPING SETS (
	(e.situacao_funcionamento),
	(e.dependencia_adm),
	(e.localizacao),
	()
);




SELECT e.situacao_funcionamento, e.dependencia_adm, count(e.co_escola) as qtd_escolas
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
)
GROUP BY GROUPING SETS (
	(e.situacao_funcionamento, e.dependencia_adm),
	()
);


SELECT e.bercario, e.pre_escola, e.ens_fundamental_anos_iniciais,
       e.ens_fundamental_anos_finais, e.ens_medio_normal,
       e.ens_medio_integrado, count(e.co_escola) as qtd_escolas
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
)
GROUP BY GROUPING SETS (
	(e.bercario),
    (e.pre_escola),
    (e.ens_fundamental_anos_iniciais),
    (e.ens_fundamental_anos_finais),
    (e.ens_medio_normal),
    (e.ens_medio_integrado),
	()
);

18 secs 448 msec.
13 rows affected.

"GroupAggregate  (cost=13531.67..19918.82 rows=13 width=30) (actual time=235.772..739.112 rows=13 loops=1)"
"  Group Key: e.pre_escola"
"  Group Key: ()"
"  Sort Key: e.ens_fundamental_anos_finais"
"    Group Key: e.ens_fundamental_anos_finais"
"  Sort Key: e.ens_medio_integrado"
"    Group Key: e.ens_medio_integrado"
"  Sort Key: e.ens_medio_normal"
"    Group Key: e.ens_medio_normal"
"  Sort Key: e.bercario"
"    Group Key: e.bercario"
"  Sort Key: e.ens_fundamental_anos_iniciais"
"    Group Key: e.ens_fundamental_anos_iniciais"
"  ->  Sort  (cost=13531.67..13572.13 rows=16186 width=30) (actual time=226.687..249.381 rows=90720 loops=1)"
"        Sort Key: e.pre_escola"
"        Sort Method: external merge  Disk: 3632kB"
"        ->  Hash Semi Join  (cost=347.57..12400.07 rows=16186 width=30) (actual time=21.877..175.790 rows=90720 loops=1)"
"              Hash Cond: (e.co_distrito = d.co_distrito)"
"              ->  Seq Scan on escola e  (cost=0.00..11121.75 rows=285975 width=39) (actual time=0.065..85.289 rows=285975 loops=1)"
"              ->  Hash  (cost=342.94..342.94 rows=370 width=9) (actual time=7.480..7.480 rows=3248 loops=1)"
"                    Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 163kB"
"                    ->  Hash Semi Join  (cost=131.76..342.94 rows=370 width=9) (actual time=3.956..6.566 rows=3248 loops=1)"
"                          Hash Cond: (d.co_municipio = m.co_municipio)"
"                          ->  Seq Scan on distrito d  (cost=0.00..180.02 rows=10302 width=15) (actual time=0.004..1.002 rows=10302 loops=1)"
"                          ->  Hash  (cost=129.26..129.26 rows=200 width=6) (actual time=2.867..2.867 rows=1668 loops=1)"
"                                Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 80kB"
"                                ->  Hash Semi Join  (cost=16.72..129.26 rows=200 width=6) (actual time=1.071..2.407 rows=1668 loops=1)"
"                                      Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"                                      ->  Seq Scan on municipio m  (cost=0.00..95.70 rows=5570 width=13) (actual time=0.006..0.546 rows=5570 loops=1)"
"                                      ->  Hash  (cost=16.47..16.47 rows=20 width=7) (actual time=0.446..0.446 rows=160 loops=1)"
"                                            Buckets: 1024  Batches: 1  Memory Usage: 15kB"
"                                            ->  Hash Semi Join  (cost=5.20..16.47 rows=20 width=7) (actual time=0.133..0.301 rows=160 loops=1)"
"                                                  Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                                                  ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.004..0.054 rows=558 loops=1)"
"                                                  ->  Hash  (cost=5.14..5.14 rows=5 width=5) (actual time=0.107..0.107 rows=37 loops=1)"
"                                                        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                                        ->  Hash Semi Join  (cost=1.35..5.14 rows=5 width=5) (actual time=0.052..0.092 rows=37 loops=1)"
"                                                              Hash Cond: (me.co_uf = u.co_uf)"
"                                                              ->  Seq Scan on mesorregiao me  (cost=0.00..3.37 rows=137 width=10) (actual time=0.004..0.018 rows=137 loops=1)"
"                                                              ->  Hash  (cost=1.34..1.34 rows=1 width=12) (actual time=0.024..0.024 rows=4 loops=1)"
"                                                                    Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                                                    ->  Seq Scan on uf u  (cost=0.00..1.34 rows=1 width=12) (actual time=0.006..0.017 rows=4 loops=1)"
"                                                                          Filter: (co_regiao = '3'::numeric)"
"                                                                          Rows Removed by Filter: 23"
"Planning time: 1.151 ms"
"Execution time: 744.648 ms"