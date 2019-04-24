<?php

    // Alunos:
    //     Bianca Gomes Rodrigues      743512
    //     Pietro Zuntini Bonfim       743588

    // Inclui a conexão
    include 'conexao.php';

    date_default_timezone_set('America/Sao_Paulo');

    $row = 1;
    
    if (($handle = fopen("Meso_Micro.csv", "r")) !== FALSE) {

        while ( (($data = fgetcsv($handle, 1000, ";")) !== FALSE) ) {

            if ($row == 1) {
                $row++;
                continue;
            }

            $num = count($data);
            echo "\n$num campos na linha $row:\n";
            $row++;

            for ($c=0; $c < $num; $c++) {
                echo $data[$c] . " | ";
            }

            // Região
            $co_regiao          = $data[0];
            $nome_regiao        = $data[1];

            $sql = "INSERT INTO regiao (co_regiao, nome_regiao) VALUES ($co_regiao, '$nome_regiao')";
            $stmt = $conexao->prepare($sql);
            $stmt->execute();

            // UF
            $co_uf              = $data[2];
            $sigla_uf           = $data[3];
            $nome_uf            = $data[4];

            $sql = "INSERT INTO uf (co_uf, nome_uf, sigla_uf, co_regiao) VALUES ($co_uf, '$nome_uf', '$sigla_uf', $co_regiao)";
            $stmt = $conexao->prepare($sql);
            $stmt->execute();

            // Municipio
            $co_municipio       = $data[5];
            $nome_municipio     = $data[6];

            $sql = "INSERT INTO municipio (co_municipio, nome_municipio, co_microrregiao) VALUES ($co_municipio, '$nome_municipio', $co_microrregiao)";
            $stmt = $conexao->prepare($sql);
            $stmt->execute();

            // Mesorregiao
            $co_mesorregiao     = $data[7];
            $nome_mesorregiao   = $data[8];
            
            $sql = "INSERT INTO mesorregiao (co_mesorregiao, nome_mesorregiao, co_uf) VALUES ($co_mesorregiao, '$nome_mesorregiao', $co_uf)";
            $stmt = $conexao->prepare($sql);
            $stmt->execute();

            // Microrregiao
            $co_microrregiao    = $data[9];
            $nome_microrregiao  = $data[10];

            $sql = "INSERT INTO microrregiao (co_microrregiao, nome_microrregiao, co_mesorregiao) VALUES ($co_microrregiao, '$nome_microrregiao', $co_mesorregiao)";
            $stmt = $conexao->prepare($sql);
            $stmt->execute();


        }
        
        fclose($handle);
    }