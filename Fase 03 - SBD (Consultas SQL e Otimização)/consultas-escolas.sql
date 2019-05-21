
-- =======================================================
-- CONSULTAS BUSCAR ESCOLAS
-- =======================================================

-- Recupera todos os UFs
SELECT *
FROM uf u;

Notebook Pietro:
383 msec.
27 rows affected.

Notebook Bianca:
240 msec.
27 rows affected.

"Seq Scan on uf u  (cost=0.00..1.27 rows=27 width=252) (actual time=0.005..0.006 rows=27 loops=1)"
"Planning time: 0.065 ms"
"Execution time: 0.048 ms"


-- Recupera todos as mesorregioes de UF = 35 (São Paulo)
SELECT me.co_mesorregiao
FROM mesorregiao me
WHERE me.co_uf = 35;

Notebook Pietro:
132 msec.
15 rows affected.

Notebook Bianca:
 1 secs 595 msec.
15 rows affected.


"Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.060..0.083 rows=15 loops=1)"
"  Filter: (co_uf = '35'::numeric)"
"  Rows Removed by Filter: 122"
"Planning time: 0.095 ms"
"Execution time: 0.119 ms"


-- Recupera todas as microrregiões que contém as mesorregiões
SELECT mi.co_microrregiao
FROM microrregiao mi
WHERE mi.co_mesorregiao IN (
    SELECT me.co_mesorregiao
    FROM mesorregiao me
    WHERE me.co_uf = 35
);

Notebook Pietro:
102 msec.
63 rows affected.

Notebook Bianca:
 378 msec.
63 rows affected.

"Hash Semi Join  (cost=3.90..15.62 rows=61 width=7) (actual time=0.209..0.360 rows=63 loops=1)"
"  Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"  ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.006..0.058 rows=558 loops=1)"
"  ->  Hash  (cost=3.71..3.71 rows=15 width=5) (actual time=0.044..0.044 rows=15 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"        ->  Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.009..0.038 rows=15 loops=1)"
"              Filter: (co_uf = '35'::numeric)"
"              Rows Removed by Filter: 122"
"Planning time: 0.342 ms"
"Execution time: 0.415 ms"


-- Recupera todos os municípios que contém as microrregiões
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
);

Notebook Pietro:
225 msec.
645 rows affected.

Notebook Bianca:
634 msec.
645 rows affected.

"Hash Semi Join  (cost=16.39..133.48 rows=609 width=6) (actual time=1.036..2.225 rows=645 loops=1)"
"  Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"  ->  Seq Scan on municipio m  (cost=0.00..95.70 rows=5570 width=13) (actual time=0.006..0.597 rows=5570 loops=1)"
"  ->  Hash  (cost=15.62..15.62 rows=61 width=7) (actual time=0.189..0.189 rows=63 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"        ->  Hash Semi Join  (cost=3.90..15.62 rows=61 width=7) (actual time=0.055..0.177 rows=63 loops=1)"
"              Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"              ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.003..0.047 rows=558 loops=1)"
"              ->  Hash  (cost=3.71..3.71 rows=15 width=5) (actual time=0.033..0.033 rows=15 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                    ->  Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.007..0.027 rows=15 loops=1)"
"                          Filter: (co_uf = '35'::numeric)"
"                          Rows Removed by Filter: 122"
"Planning time: 0.452 ms"
"Execution time: 2.323 ms"


-- Recupera todos os distritos que contém os municípios
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
);

Notebook Pietro:
98 msec.
1038 rows affected.

Notebook Bianca:
308 msec.
1038 rows affected.

"Hash Semi Join  (cost=141.09..360.68 rows=1126 width=9) (actual time=3.387..4.728 rows=1038 loops=1)"
"  Hash Cond: (d.co_municipio = m.co_municipio)"
"  ->  Seq Scan on distrito d  (cost=0.00..180.02 rows=10302 width=15) (actual time=0.004..0.885 rows=10302 loops=1)"
"  ->  Hash  (cost=133.48..133.48 rows=609 width=6) (actual time=1.905..1.905 rows=645 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 33kB"
"        ->  Hash Semi Join  (cost=16.39..133.48 rows=609 width=6) (actual time=1.075..1.775 rows=645 loops=1)"
"              Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"              ->  Seq Scan on municipio m  (cost=0.00..95.70 rows=5570 width=13) (actual time=0.003..0.484 rows=5570 loops=1)"
"              ->  Hash  (cost=15.62..15.62 rows=61 width=7) (actual time=0.210..0.210 rows=63 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                    ->  Hash Semi Join  (cost=3.90..15.62 rows=61 width=7) (actual time=0.075..0.196 rows=63 loops=1)"
"                          Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                          ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.003..0.046 rows=558 loops=1)"
"                          ->  Hash  (cost=3.71..3.71 rows=15 width=5) (actual time=0.041..0.041 rows=15 loops=1)"
"                                Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                ->  Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.008..0.038 rows=15 loops=1)"
"                                      Filter: (co_uf = '35'::numeric)"
"                                      Rows Removed by Filter: 122"
"Planning time: 0.601 ms"
"Execution time: 5.005 ms"


-- Recupera todas as escolas disponíveis contidas nos distritos
SELECT *
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
);

Notebook Pietro:
16 secs 150 msec.
38553 rows affected.

Notebook Bianca:
15 secs 900 msec.
38553 rows affected.

"Hash Semi Join  (cost=374.76..12795.20 rows=49259 width=197) (actual time=3.455..250.855 rows=38553 loops=1)"
"  Hash Cond: (e.co_distrito = d.co_distrito)"
"  ->  Seq Scan on escola e  (cost=0.00..11121.75 rows=285975 width=197) (actual time=0.004..157.927 rows=285975 loops=1)"
"  ->  Hash  (cost=360.68..360.68 rows=1126 width=9) (actual time=3.435..3.435 rows=1038 loops=1)"
"        Buckets: 2048  Batches: 1  Memory Usage: 58kB"
"        ->  Hash Semi Join  (cost=141.09..360.68 rows=1126 width=9) (actual time=2.368..3.263 rows=1038 loops=1)"
"              Hash Cond: (d.co_municipio = m.co_municipio)"
"              ->  Seq Scan on distrito d  (cost=0.00..180.02 rows=10302 width=15) (actual time=0.002..0.642 rows=10302 loops=1)"
"              ->  Hash  (cost=133.48..133.48 rows=609 width=6) (actual time=1.280..1.280 rows=645 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 33kB"
"                    ->  Hash Semi Join  (cost=16.39..133.48 rows=609 width=6) (actual time=0.709..1.177 rows=645 loops=1)"
"                          Hash Cond: (m.co_microrregiao = mi.co_microrregiao)"
"                          ->  Seq Scan on municipio m  (cost=0.00..95.70 rows=5570 width=13) (actual time=0.005..0.337 rows=5570 loops=1)"
"                          ->  Hash  (cost=15.62..15.62 rows=61 width=7) (actual time=0.152..0.152 rows=63 loops=1)"
"                                Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                                ->  Hash Semi Join  (cost=3.90..15.62 rows=61 width=7) (actual time=0.044..0.137 rows=63 loops=1)"
"                                      Hash Cond: (mi.co_mesorregiao = me.co_mesorregiao)"
"                                      ->  Seq Scan on microrregiao mi  (cost=0.00..9.58 rows=558 width=12) (actual time=0.002..0.035 rows=558 loops=1)"
"                                      ->  Hash  (cost=3.71..3.71 rows=15 width=5) (actual time=0.027..0.027 rows=15 loops=1)"
"                                            Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                                            ->  Seq Scan on mesorregiao me  (cost=0.00..3.71 rows=15 width=5) (actual time=0.006..0.021 rows=15 loops=1)"
"                                                  Filter: (co_uf = '35'::numeric)"
"                                                  Rows Removed by Filter: 122"
"Planning time: 1.261 ms"
"Execution time: 252.849 ms"


------------------------------------------------------------------------------------------------------------------------------


-- Recuperar todos os distritos de DETERMINADO município
SELECT d.co_distrito
FROM distrito d
WHERE d.co_municipio = 3550308;

Notebook Pietro:
84 msec.
96 rows affected.

Notebook Bianca:
114 msec.
96 rows affected.

"Seq Scan on distrito d  (cost=0.00..205.78 rows=96 width=9) (actual time=1.729..2.494 rows=96 loops=1)"
"  Filter: (co_municipio = '3550308'::numeric)"
"  Rows Removed by Filter: 10206"
"Planning time: 0.136 ms"
"Execution time: 2.532 ms"


-- Recupera todas as escolas contidas nestes distritos
SELECT *
FROM escola e
WHERE e.co_distrito IN (
    SELECT d.co_distrito
    FROM distrito d
    WHERE d.co_municipio = 3550308
);

Notebook Pietro:
496 msec.
9822 rows affected.

Notebook Bianca:
864 msec.
9822 rows affected.

"Hash Semi Join  (cost=206.97..12126.13 rows=4200 width=197) (actual time=3.187..229.089 rows=9822 loops=1)"
"  Hash Cond: (e.co_distrito = d.co_distrito)"
"  ->  Seq Scan on escola e  (cost=0.00..11121.75 rows=285975 width=197) (actual time=0.004..165.576 rows=285975 loops=1)"
"  ->  Hash  (cost=205.78..205.78 rows=96 width=9) (actual time=3.156..3.156 rows=96 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 12kB"
"        ->  Seq Scan on distrito d  (cost=0.00..205.78 rows=96 width=9) (actual time=1.759..2.954 rows=96 loops=1)"
"              Filter: (co_municipio = '3550308'::numeric)"
"              Rows Removed by Filter: 10206"
"Planning time: 0.561 ms"
"Execution time: 229.782 ms"



------------------------------------------------------------------------------------------------------------------------------

-- Quando o Usuário selecionar um Estado

    -- Na tabela
    SELECT *
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
    );

    -- No select de Municípios
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
    );


-- Quando o Usuário selecionar um Município

    -- Na tabela
    SELECT *
    FROM escola e
    WHERE e.co_distrito IN (
        SELECT d.co_distrito
        FROM distrito d
        WHERE d.co_municipio = 3550308
    );

    -- No select de Escolas
    SELECT *
    FROM escola e
    WHERE e.co_distrito IN (
        SELECT d.co_distrito
        FROM distrito d
        WHERE d.co_municipio = 3550308
    );


-- Quando o Usuário selecionar uma Escola

    -- Na tabela
    SELECT *
    FROM escola e 
    WHERE e.nome_escola ILIKE '%uirapuru%';

-- =======================================================
-- CONSULTAS DE FILTROS
-- =======================================================

-- Filtros vão adicionando cláusulas AND na consulta principal


-- =======================================================
-- CONSULTAS DAS ESTATÍSTICAS
-- =======================================================

SELECT *
FROM regiao r;

-- r = 3

--seleciona os ufs
SELECT *
FROM uf u
WHERE u.co_regiao = 3;

-- seleciona as meso
SELECT me.co_mesorregiao
FROM mesorregiao me
WHERE me.co_uf IN (
    SELECT u.co_uf
	FROM uf u
	WHERE u.co_regiao = 3
);

-- seleciona as micro
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
);

-- seleciona os municipios
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
);

-- seleciona os distritos
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
);

-- seleciona as escolas
SELECT e.nome_escola
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


-- seleciona as qtd de escolas 'em atividade', 'paralisada' e 'extinta'
SELECT e.situacao_funcionamento as Situacao, count(e.co_escola) as Quantidade
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
GROUP BY e.situacao_funcionamento;

11 secs 84 msec.
3 rows affected.


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