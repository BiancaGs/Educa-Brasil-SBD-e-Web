-- =======================================================
-- CONSULTA 1
-- =======================================================

-- TODO

CREATE OR REPLACE FUNCTION recuperarEscolas( ....., limit int, offset int )  
RETURNS TABLE ( COMO RETORNAR TODAS AS COLUNAS DA ESCOLA ) AS $$
BEGIN
    
END
$$ LANGUAGE plpgsql;



-- =======================================================
-- CONSULTA 2
-- =======================================================

CREATE OR REPLACE FUNCTION recuperarEstatisticas( brasil boolean, codigoRegiao varchar(1), codigoEstado varchar(2), codigoMunicipio varchar(7) )
RETURNS TABLE ( g_bercario integer, g_creche integer, g_pe integer, g_efi integer,
                g_efii integer, g_emn integer, g_emi integer, g_situacao integer, g_dep integer,
                g_localizacao integer, bercario escola.bercario%TYPE, creche escola.creche%TYPE,
                pre_escola escola.pre_escola%TYPE, ens_fundamental_anos_iniciais escola.ens_fundamental_anos_iniciais%TYPE,
                ens_fundamental_anos_finais escola.ens_fundamental_anos_finais%TYPE, ens_medio_normal escola.ens_medio_normal%TYPE,
                ens_medio_integrado escola.ens_medio_integrado%TYPE, situacao_funcionamento escola.situacao_funcionamento%TYPE,
                dependencia_adm escola.dependencia_adm%TYPE,  localizacao escola.localizacao%TYPE, qtd_escolas bigint ) AS $$
DECLARE
    sql text := 'SELECT
        GROUPING(e.bercario) g_bercario, GROUPING(e.creche) g_creche, GROUPING(e.pre_escola) g_pe, GROUPING(e.ens_fundamental_anos_iniciais) g_efi,
        GROUPING(e.ens_fundamental_anos_finais) g_efii, GROUPING(e.ens_medio_normal) g_emn,
        GROUPING(e.ens_medio_integrado) g_emi, GROUPING(e.situacao_funcionamento) g_situacao,
        GROUPING(e.dependencia_adm) g_dep, GROUPING(e.localizacao) g_localizacao,
        e.bercario, e.creche, e.pre_escola, e.ens_fundamental_anos_iniciais, e.ens_fundamental_anos_finais, e.ens_medio_normal,
        e.ens_medio_integrado,e.situacao_funcionamento, e.dependencia_adm, e.localizacao, count(e.co_escola) as qtd_escolas
    FROM escola e';
    g_text text := ' GROUP BY GROUPING SETS (
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
    )';
BEGIN
    IF brasil IS NULL THEN

        IF codigoRegiao IS NOT NULL THEN

            -- SQL Região
            sql := sql || ' WHERE e.co_distrito IN (
                SELECT d.co_distrito
                FROM distritos_regiao' || $2 || ' d)';

            RETURN QUERY EXECUTE sql || g_text
            USING codigoRegiao;

        ELSIF codigoEstado IS NOT NULL THEN

            -- SQL Estado
            sql := sql || ' WHERE e.co_distrito IN (
                    SELECT d.co_distrito
                    FROM distritos' || $3 || ' d)';

            RETURN QUERY EXECUTE sql || g_text
            USING codigoEstado;


        ELSIF codigoMunicipio IS NOT NULL THEN

            -- SQL Município
            sql := sql || ' WHERE e.co_distrito IN (
                    SELECT d.co_distrito
                    FROM distrito d
                    WHERE d.co_municipio = ' || $4 || ')';

            RETURN QUERY EXECUTE sql || g_text
            USING codigoMunicipio;

        END IF;

    ELSE

        -- SQL Brasil

	    RETURN QUERY EXECUTE sql || g_text;

    END IF;

END
$$ LANGUAGE plpgsql;


-- Exemplos de chamada
SELECT * FROM recuperarEstatisticas(true, NULL, NULL, NULL);        -- Brasil
SELECT * FROM recuperarEstatisticas(NULL, '4', NULL, NULL);         -- Região
SELECT * FROM recuperarEstatisticas(NULL, NULL, '35', NULL);        -- Estado
SELECT * FROM recuperarEstatisticas(NULL, NULL, NULL, '3552205');   -- Município