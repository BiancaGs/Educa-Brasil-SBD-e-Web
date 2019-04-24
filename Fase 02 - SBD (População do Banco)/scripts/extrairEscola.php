<?php

    // Alunos:
    //     Bianca Gomes Rodrigues      743512
    //     Pietro Zuntini Bonfim       743588

    // Inclui a conexão
    include 'conexao.php';

    // =======================================================
    // Funções auxiliares
    // =======================================================

    function sim_ou_nao($valor) {
        switch ($valor) {
            case 0:
                return 'Não';
                break;
            case 1:
                return 'Sim';
                break;
            default:
                return '-1';
                break;
        }
    }

    function formata_data($data) {

        if (empty($data))
            return 'NULL';

        $strings = explode('/', $data);

        $dia = $strings[1];
        $mes = $strings[0];
        $ano = $strings[2];
        
        $data_formatada = $dia.'/'.$mes.'/'.$ano;

        return "'".$data_formatada."'";
    }

    function verifica_vazio($valor) {
        if (empty($valor))
            return 0;
        else
            return $valor;
    }


    // Para controle de erros
    $linhas_erro = array();
    $erros = array();


    $row = 1;
    
    if (($handle = fopen("ESCOLAS.csv", "r")) !== FALSE) {

        $i = 0;
        while ( (($data = fgetcsv($handle, 1000, ";")) !== FALSE ) ) {
            
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
            
            $i++;

            $co_escola                      = $data[0];
            $nome_escola                    = $data[1];

            $situacao_funcionamento         = $data[2];
            switch ($situacao_funcionamento) {
                case 1:
                    $situacao_funcionamento = "Em atividade";
                    break;
                case 2:
                    $situacao_funcionamento = "Paralisada";
                    break;
                case 3:
                    $situacao_funcionamento = "Extinta";
                    break;
                case 4:
                    $situacao_funcionamento = "Extinta";
                    break;
                default:
                    $situacao_funcionamento = "-1";
                    break;
            }

            $inicio_ano_letivo              = formata_data($data[3]);
            $termino_ano_letivo             = formata_data($data[4]);

            $co_regiao                      = $data[5];
            $co_uf                          = $data[8];
            $co_mesorregiao                 = $data[6];
            $co_microrregiao                = $data[7];
            $co_municipio                   = $data[9];
            $co_distrito                    = $data[10];

            $dependencia_adm                = $data[11];
            switch ($dependencia_adm) {
                case 1:
                    $dependencia_adm = "Federal";
                    break;
                case 2:
                    $dependencia_adm = "Estadual";
                    break;
                case 3:
                    $dependencia_adm = "Municipal";
                    break;
                case 4:
                    $dependencia_adm = "Privada";
                    break;
                default:
                    $dependencia_adm = "-1";
                    break;
            }

            $localizacao                    = $data[12];
            switch ($localizacao) {
                case 1:
                    $localizacao = "Urbana";
                    break;
                case 2:
                    $localizacao = "Rural";
                    break;
                default:
                    $localizacao = "-1";
                    break;
            }

            $regulamentada                  = $data[13];
            switch ($regulamentada) {
                case 0:
                    $regulamentada = "Não";
                    break;
                case 1:
                    $regulamentada = "Sim";
                    break;
                case 2:
                    $regulamentada = "Não";
                    break;
                default:
                    $regulamentada = "-1";
                    break;
            }
            
            $qtd_salas_existentes           = verifica_vazio($data[34]);
            $qtd_salas_utilizadas           = verifica_vazio($data[35]);
            $qtd_funcionarios               = verifica_vazio($data[37]);

            $acessibilidade_deficiencia     = sim_ou_nao($data[45]);
            $agua_filtrada                  = sim_ou_nao($data[14]);
            $esgoto                         = sim_ou_nao($data[15]);
            $coleta_de_lixo                 = sim_ou_nao($data[16]);
            $reciclagem                     = sim_ou_nao($data[17]);
            $sala_diretoria                 = sim_ou_nao($data[18]);
            $sala_professor                 = sim_ou_nao($data[19]);
            $laboratorio_informatica        = sim_ou_nao($data[20]);
            $laboratorio_ciencias           = sim_ou_nao($data[21]);
            $quadra_esportes                = sim_ou_nao($data[22]);
            $cozinha                        = sim_ou_nao($data[23]);
            $biblioteca                     = sim_ou_nao($data[24]);
            $sala_leitura                   = sim_ou_nao($data[25]);
            $parque_infantil                = sim_ou_nao($data[26]);
            $bercario                       = sim_ou_nao($data[27]);
            $secretaria                     = sim_ou_nao($data[28]);
            $refeitorio                     = sim_ou_nao($data[29]);
            $alimentacao                    = sim_ou_nao($data[38]);
            $auditorio                      = sim_ou_nao($data[30]);
            $alojamento_alunos              = sim_ou_nao($data[31]);
            $alojamento_professores         = sim_ou_nao($data[32]);
            $area_verde                     = sim_ou_nao($data[33]);
            $internet                       = sim_ou_nao($data[36]);
            $creche                         = sim_ou_nao($data[39]);
            $pre_escola                     = sim_ou_nao($data[40]);
            $ens_fundamental_anos_iniciais  = sim_ou_nao($data[41]);
            $ens_fundamental_anos_finais    = sim_ou_nao($data[42]);
            $ens_medio_normal               = sim_ou_nao($data[44]);
            $ens_medio_integrado            = sim_ou_nao($data[43]);
            
            $sql = "INSERT INTO escola (co_escola, nome_escola, situacao_funcionamento, inicio_ano_letivo, termino_ano_letivo, co_distrito, dependencia_adm, localizacao, regulamentada, qtd_salas_existentes, qtd_salas_utilizadas, qtd_funcionarios, agua_filtrada, esgoto, coleta_de_lixo, reciclagem, sala_diretoria, sala_professor, laboratorio_informatica, laboratorio_ciencias, quadra_esportes, cozinha, biblioteca, sala_leitura, parque_infantil, bercario, secretaria, refeitorio, alimentacao, auditorio, alojamento_alunos, alojamento_professores, area_verde, internet, creche, pre_escola, ens_fundamental_anos_iniciais, ens_fundamental_anos_finais, ens_medio_normal, ens_medio_integrado, acessibilidade_deficiencia) VALUES ($co_escola, '$nome_escola', '$situacao_funcionamento', $inicio_ano_letivo, $termino_ano_letivo, $co_distrito, '$dependencia_adm', '$localizacao', '$regulamentada', $qtd_salas_existentes, $qtd_salas_utilizadas, $qtd_funcionarios, '$agua_filtrada', '$esgoto', '$coleta_de_lixo', '$reciclagem', '$sala_diretoria', '$sala_professor', '$laboratorio_informatica', '$laboratorio_ciencias', '$quadra_esportes', '$cozinha', '$biblioteca', '$sala_leitura', '$parque_infantil', '$bercario', '$secretaria', '$refeitorio', '$alimentacao', '$auditorio', '$alojamento_alunos', '$alojamento_professores', '$area_verde', '$internet', '$creche', '$pre_escola', '$ens_fundamental_anos_iniciais', '$ens_fundamental_anos_finais', '$ens_medio_normal', '$ens_medio_integrado', '$acessibilidade_deficiencia')";

            $stmt = $conexao->prepare($sql);
            if (!$stmt->execute()) {
                array_push($linhas_erro, $row);
                array_push($erros, $stmt->errorInfo());
            }
            
        }

        $output_linhas = "";
        $output_linhas .= "Linhas com erro: ";
        foreach ($linhas_erro as $linha) {
            $output_linhas .= $linha.', ';
        }

        $output_erros = "";
        $output_erros .= "Erros:\n";
        $output_erros .= print_r($erros, true);

        file_put_contents('erros_linhas-'.date('dmY-His').'.txt', $output_linhas);
        file_put_contents('erros-'.date('dmY-His').'.txt', $output_erros);
        
        fclose($handle);
    }