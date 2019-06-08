-- BRASIL
SELECT
    GROUPING(e.bercario) g_bercario, GROUPING(e.creche) g_creche, GROUPING(e.pre_escola) g_pe, GROUPING(e.ens_fundamental_anos_iniciais) g_efi,
    GROUPING(e.ens_fundamental_anos_finais) g_efii, GROUPING(e.ens_medio_normal) g_emn,
   	GROUPING(e.ens_medio_integrado) g_emi, GROUPING(e.situacao_funcionamento) g_situacao,
   	GROUPING(e.dependencia_adm) g_dep, GROUPING(e.localizacao) g_localizacao,
	e.bercario, e.creche, e.pre_escola, e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais, e.ens_medio_normal,
	e.ens_medio_integrado,e.situacao_funcionamento, e.dependencia_adm, e.localizacao, count(e.co_escola) as qtd_escolas
FROM escola e
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

-- REGIAO
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

-- ESTADO
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
			    WHERE me.co_uf = 35
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


-- MUNICIPIO
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
    WHERE d.co_municipio = 3552205
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