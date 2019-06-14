/// <reference path='../lib/jquery/jquery-3.3.1.min.js' />


$(document).ready(function() {

    // Fazer com que o mapa ocupe a altura restante
    $('#nav-mapa').height($(window).height() - $('#header-principal').height());

    // Ao abrir a página, carregar as regiões
    $.ajax({
        url: 'RecuperarRegiao',
        method: 'POST',
        data: {
            recuperarRegioes: "sim"
        },
        datatype: 'html',
        success: function(retorno) {
            
            $('#select-regiao').html(retorno);
            
        },
        error: function(retorno) {
            console.log('Error');
            console.log(retorno);
        }
    });


    // Recupera a quantidade de escolas por Estado
    $.ajax({
        url: 'RecuperarQuantidadeEscolasEstado',
        method: 'POST',
        data: {
            recuperarIndex: "sim"
        },
        datatype: 'json',
        success: function(retorno) {
            
            // Cria o mapa com os dados do json de retorno
            var json = JSON.parse(retorno);
            // Carregar também o mapa do Brasil
            criarGraficoPrincipal(json);
            
        },
        error: function(retorno) {
            console.log('Error');
            console.log(retorno);
        }
    });


    // Recupera as estatísticas do Brasil
    $.ajax({
        url: 'RecuperarEstatisticas',
        method: 'POST',
        data: {
            recuperarEstatisticas: "sim"
        },
        datatype: 'json',
        success: function(retorno) {

            var json = JSON.parse(retorno);

            // Cria os gráficos
            criarGraficoSituacao(json.Atividade, json.Paralisada, json.Extinta);
            criarGraficoDependencias(json.Federal, json.Estadual, json.Municipal, json.Privada);
            criarGraficoLocalizacao(json.Urbana, json.Rural);
            criarGraficoOfertas(json.B, json.C, json.PE, json.EFI, json.EFII, json.EMN, json.EMI);

            // Preenche a quantidade de escolas
            $('.qtd-escolas').text(json.Total);

        },
        error: function(retorno) {
            console.log('Error');
            console.log(retorno);
        }
    });


    // =======================================================
    // Recuperar os Estados à partir de uma Região
    // =======================================================

    $('#select-regiao').change(function() {
        
        var dados_regiao = $(this).select2('data');
        var regiao = dados_regiao[0].id;
        var nome_regiao = dados_regiao[0].text;

        $.ajax({
            url: 'RecuperarEstados',
            method: 'POST',
            data: {
                regiao: regiao
            },
            datatype: 'html',
            success: function(retorno) {
                $('#select-estado').html(retorno);
            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });
        
        // Atualizar o nome na view
        $('#nav-estatisticas ol').html('<li class="breadcrumb-item active nome-regiao">'+nome_regiao+'</li>');
        
        // Zera o nome do Municipio e o seu select
        $('.nome-municipio').html('');
        $('#select-municipio').html('<option></option>');


        // Recupera as estatísticas da Região
        $.ajax({
            url: 'RecuperarEstatisticas',
            method: 'POST',
            data: {
                regiao: regiao
            },
            datatype: 'json',
            success: function(retorno) {

                var json = JSON.parse(retorno);

                // Cria os gráficos
                criarGraficoSituacao(json.Atividade, json.Paralisada, json.Extinta);
                criarGraficoDependencias(json.Federal, json.Estadual, json.Municipal, json.Privada);
                criarGraficoLocalizacao(json.Urbana, json.Rural);
                criarGraficoOfertas(json.B, json.C, json.PE, json.EFI, json.EFII, json.EMN, json.EMI);

                // Preenche a quantidade de escolas
                $('.qtd-escolas').text(json.Total);

            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });

        // Recupera a quantidade de escolas por Estado
        $.ajax({
            url: 'RecuperarQuantidadeEscolasEstado',
            method: 'POST',
            data: {
                recuperarIndex: "sim"
            },
            datatype: 'json',
            success: function(retorno) {
                
                // Cria o mapa com os dados do json de retorno
                var json = JSON.parse(retorno);
                // Carregar também o mapa do Brasil
                criarMapaRegiao(json, regiao);
                
            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });

    });

    // =======================================================
    // Recuperar os Municipios à partir de um Estado
    // =======================================================

    $('#select-estado').change(function() {
        
        var dados_estado = $(this).select2('data');
        var estado = dados_estado[0].id;
        var nome_estado = dados_estado[0].text;

        $.ajax({
            url: 'RecuperarMunicipios',
            method: 'POST',
            data: {
                estado: estado
            },
            datatype: 'html',
            success: function(retorno) {
                $('#select-municipio').html(retorno);
            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
            
        });
        
        // Atualizar o nome na view
        var nome_regiao = $('.nome-regiao').text();
        $('#nav-estatisticas ol').html('<li class="breadcrumb-item active nome-regiao">'+nome_regiao+'</li><li class="breadcrumb-item active nome-estado">'+nome_estado+'</li>');


        // Recupera as estatísticas do Estado
        $.ajax({
            url: 'RecuperarEstatisticas',
            method: 'POST',
            data: {
                estado: estado
            },
            datatype: 'json',
            success: function(retorno) {

                var json = JSON.parse(retorno);

                // Cria os gráficos
                criarGraficoSituacao(json.Atividade, json.Paralisada, json.Extinta);
                criarGraficoDependencias(json.Federal, json.Estadual, json.Municipal, json.Privada);
                criarGraficoLocalizacao(json.Urbana, json.Rural);
                criarGraficoOfertas(json.B, json.C, json.PE, json.EFI, json.EFII, json.EMN, json.EMI);

                // Preenche a quantidade de escolas
                $('.qtd-escolas').text(json.Total);

            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });

        // Recupera a quantidade de escolas por Estado
        $.ajax({
            url: 'RecuperarQuantidadeEscolasEstado',
            method: 'POST',
            data: {
                recuperarIndex: "sim"
            },
            datatype: 'json',
            success: function(retorno) {
                
                // Cria o mapa com os dados do json de retorno
                var json = JSON.parse(retorno);
                // Carregar também o mapa do Brasil
                criarMapaEstado(json, estado);
                
            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });

    });
    
    $('#select-municipio').change(function () {
        
        // Recupera os dados do Municipio selecionado
        var dados_municipio = $(this).select2('data');
        var municipio = dados_municipio[0].id;
        var nome_municipio = dados_municipio[0].text;

        // Do Estado também
        var dados_estado = $('#select-estado').select2('data');
        var estado = dados_estado[0].id;
        var nome_estado = dados_estado[0].text;
      
        // Atualizar o nome na view
        var nome_regiao = $('.nome-regiao').text();
        var nome_estado = $('.nome-estado').text();
        $('#nav-estatisticas ol').html('<li class="breadcrumb-item active nome-regiao">'+nome_regiao+'</li><li class="breadcrumb-item active nome-estado">'+nome_estado+'</li><li class="breadcrumb-item active nome-municipio">'+nome_municipio+'</li>');

        // Recupera as estatísticas do Municipio
        $.ajax({
            url: 'RecuperarEstatisticas',
            method: 'POST',
            data: {
                municipio: municipio
            },
            datatype: 'json',
            success: function(retorno) {

                var json = JSON.parse(retorno);

                // Cria os gráficos
                criarGraficoSituacao(json.Atividade, json.Paralisada, json.Extinta);
                criarGraficoDependencias(json.Federal, json.Estadual, json.Municipal, json.Privada);
                criarGraficoLocalizacao(json.Urbana, json.Rural);
                criarGraficoOfertas(json.B, json.C, json.PE, json.EFI, json.EFII, json.EMN, json.EMI);

                // Preenche a quantidade de escolas
                $('.qtd-escolas').text(json.Total);

                // Recupera a quantidade de escolas por Estado
                $.ajax({
                    url: 'RecuperarQuantidadeEscolasEstado',
                    method: 'POST',
                    data: {
                        recuperarIndex: "sim"
                    },
                    datatype: 'json',
                    success: function(retorno) {
                        
                        // Cria o mapa com os dados do json de retorno
                        var jsonQtd = JSON.parse(retorno);
                        // Carregar também o mapa do Brasil
                        criarMapaMunicipio(jsonQtd, estado, nome_municipio, json.Latitude, json.Longitude);
                        
                    },
                    error: function(retorno) {
                        console.log('Error');
                        console.log(retorno);
                    }
                });

            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });

        

    });


    // Criação dos selects
    $("#select-regiao").select2({
        placeholder: "Região"
    });
    $("#select-estado").select2({
        placeholder: "Estado"
    });
    $("#select-municipio").select2({
        placeholder: "Município"
    });

});