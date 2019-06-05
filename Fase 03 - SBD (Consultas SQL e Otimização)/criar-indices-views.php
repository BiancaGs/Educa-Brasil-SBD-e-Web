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

        $sql = "CREATE INDEX distritos{$i}_idx_distrito ON distritos{$i} (co_distrito)";

        $stmt = $conexao->prepare($sql);
        if (!$stmt->execute())
            print_r($stmt->errorInfo());

        $i++;

    }
