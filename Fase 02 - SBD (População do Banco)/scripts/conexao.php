<?php

    // Alunos:
    //     Bianca Gomes Rodrigues      743512
    //     Pietro Zuntini Bonfim       743588

    // Configuração do PostgreSQL
    $host       = "localhost";
    $banco      = "escolas_brasileiras";
    $usuario    = "postgres";
    $senha      = "1234";

    try {
        $conexao = new PDO("pgsql:host=$host;dbname=$banco", $usuario, $senha);
    } catch ( PDOException $e ) {
        echo $e->getMessage();
    }