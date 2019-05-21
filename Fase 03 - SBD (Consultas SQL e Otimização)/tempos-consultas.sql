-- Consulta 1

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
    AND d.co_municipio = 3552205
)
AND e.nome_escola ILIKE '%uirapuru%';


Notebook Pietro:

12 secs 332 msec.
2 rows affected.


Notebook Bianca:

16 secs 221 msec.
2 rows affected.