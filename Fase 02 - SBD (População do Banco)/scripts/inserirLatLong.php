<?php

    // =======================================================
    // Script para criação das Views
    // Autores: Bianca e Pietro
    // =======================================================

    // Inclui a conexão
    include 'conexao.php';

    $row = 1;
    
    if (($handle = fopen("municipios.csv", "r")) !== FALSE) {

        while ( (($data = fgetcsv($handle, 1000, ",")) !== FALSE) ) {
            
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

            $latitude       = $data[2];
            $longitude      = $data[3];
            $co_municipio   = $data[0];

            $sql = "UPDATE municipio SET latitude = ?, longitude = ? WHERE co_municipio = ?";

            $stmt = $conexao->prepare($sql);
            $stmt->bindParam(1, $latitude);
            $stmt->bindParam(2, $longitude);
            $stmt->bindParam(3, $co_municipio);

            if (!$stmt->execute())
                print_r($stmt->errorInfo());

        }
        
        fclose($handle);
    }