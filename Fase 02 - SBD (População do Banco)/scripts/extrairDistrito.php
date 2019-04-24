<?php

    // Alunos:
    //     Bianca Gomes Rodrigues      743512
    //     Pietro Zuntini Bonfim       743588

    // Inclui a conexão
    include 'conexao.php';

    $row = 1;
    
    if (($handle = fopen("Distritos.csv", "r")) !== FALSE) {

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

            $co_distrito    = $data[0];
            $co_municipio   = $data[1];
            $nome_distrito  = $data[5];

            $sql = "INSERT INTO distrito (co_distrito, nome_distrito, co_municipio) VALUES (?, ?, ?)";

            $stmt = $conexao->prepare($sql);
            $stmt->bindParam(1, $co_distrito);
            $stmt->bindParam(2, $nome_distrito);
            $stmt->bindParam(3, $co_municipio);
            $stmt->execute();

        }
        
        fclose($handle);
    }