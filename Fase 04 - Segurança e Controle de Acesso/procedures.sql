-- =======================================================
-- CONSULTA 1
-- =======================================================

-- TODO

-- Exemplo Sahudy
CREATE OR REPLACE FUNCTION buscaHistoricoPartidas( Vtime VARCHAR(100), ordem INT, Limite INT, Maximo INT )  
RETURNS TABLE (timeA VARCHAR(100), cont NUMERIC) AS $$
BEGIN
	CASE ordem
		WHEN 1 THEN
			RETURN QUERY 
				SELECT y.time_2, SUM(jogos) as num_jogos 
				FROM jogos;
					
		WHEN 2 THEN
			RETURN QUERY 
                SELECT y.time_1, SUM(jogos) as num_jogos 				
                FROM jogos;
		ELSE
			RAISE EXCEPTION 'Insira um valor de ordenador valido, entre 1 e 2';				
	END CASE;
END
$$ LANGUAGE plpgsql;




-- =======================================================
-- CONSULTA 2
-- =======================================================


CREATE OR REPLACE FUNCTION recuperarEstatisticasRegiao( codigoRegiao varchar(1) )  
RETURNS TABLE ( g_bercario integer, g_creche integer, g_pe integer, g_efi integer, 
                g_efii integer, g_emn integer, g_emi integer, g_situacao integer, g_dep integer, 
                g_localizacao integer, bercario escola.bercario%TYPE, creche escola.creche%TYPE, 
                pre_escola escola.pre_escola%TYPE, ens_fundamental_anos_iniciais escola.ens_fundamental_anos_iniciais%TYPE, 
                ens_fundamental_anos_finais escola.ens_fundamental_anos_finais%TYPE, ens_medio_normal escola.ens_medio_normal%TYPE, 
                ens_medio_integrado escola.ens_medio_integrado%TYPE, situacao_funcionamento escola.situacao_funcionamento%TYPE, 
                dependencia_adm escola.dependencia_adm%TYPE,  localizacao escola.localizacao%TYPE, qtd_escolas bigint ) AS $$
BEGIN
	RETURN QUERY EXECUTE
        'SELECT
            GROUPING(e.bercario) g_bercario, GROUPING(e.creche) g_creche, GROUPING(e.pre_escola) g_pe, GROUPING(e.ens_fundamental_anos_iniciais) g_efi,
            GROUPING(e.ens_fundamental_anos_finais) g_efii, GROUPING(e.ens_medio_normal) g_emn,
            GROUPING(e.ens_medio_integrado) g_emi, GROUPING(e.situacao_funcionamento) g_situacao,
            GROUPING(e.dependencia_adm) g_dep, GROUPING(e.localizacao) g_localizacao,
            e.bercario, e.creche, e.pre_escola, e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais, e.ens_medio_normal,
            e.ens_medio_integrado,e.situacao_funcionamento, e.dependencia_adm, e.localizacao, count(e.co_escola) as qtd_escolas
        FROM escola e
        WHERE e.co_distrito IN (
            SELECT d.co_distrito
            FROM distritos_regiao' || $1 || ' d
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
        )'
        USING codigoRegiao;
END
$$ LANGUAGE plpgsql;


SELECT * FROM recuperarestatisticasregiao('1');

