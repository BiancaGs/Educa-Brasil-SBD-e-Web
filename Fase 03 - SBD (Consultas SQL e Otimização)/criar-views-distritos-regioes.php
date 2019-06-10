<?php

    $host       = "localhost";
    $banco      = "escolas_brasileiras";
    $usuario    = "postgres";
    $senha      = "1234";

    try {
        $conexao = new PDO("pgsql:host=$host;dbname=$banco", $usuario, $senha);
    } catch ( PDOException $e ) {
        echo $e->getMessage();
    }

    $i = 1;

    while ($i < 6) {

        $sql = "CREATE MATERIALIZED VIEW distritos_regiao$i AS
            SELECT d.co_distrito, d.nome_distrito, d.co_municipio
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
                            WHERE u.co_regiao = $i
                        )
                    )
                )
            )";

        $stmt = $conexao->prepare($sql);
        if (!$stmt->execute()) {
            print_r($stmt->errorInfo());
        }

        $i++;

    }
