<?php

    // =======================================================
    // Script para criação das Views
    // Autores: Bianca e Pietro
    // =======================================================

    $host       = "localhost";
    $banco      = "escolas_brasileiras";
    $usuario    = "postgres";
    $senha      = "1234";

    try {
        $conexao = new PDO("pgsql:host=$host;dbname=$banco", $usuario, $senha);
    } catch ( PDOException $e ) {
        echo $e->getMessage();
    }

    $i = 11;

    while ($i < 54) {

        if ($i == 18)   $i = 21;
        if ($i == 30)   $i = 31;
        if ($i == 34)   $i = 35;
        if ($i == 36)   $i = 41;
        if ($i == 44)   $i = 50;

        $sql = "CREATE MATERIALIZED VIEW distritos$i AS
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
                        WHERE me.co_uf = $i
                    )
                )
            )";

        $stmt = $conexao->prepare($sql);
        $stmt->execute();

        $i++;

    }
