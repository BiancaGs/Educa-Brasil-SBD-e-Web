/// <reference path='../lib/jquery/jquery-3.3.1.min.js' />
/// <reference path='../lib/mdbootstrap/js/datatables.js' />

// =======================================================
// Função para iniciar/reinicializar a DataTable
// =======================================================

function inicializaDataTable() {
    $('#tabela-escolas').DataTable({
        "language": {
            "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/Portuguese-Brasil.json"
        },
        "processing": true,
        "serverSide": true,
        "ajax": {
            "url": 'RecuperarEscolasTabela',
            "type": 'GET',
            "data": {
                "brasil": "sim"
            }
        },
        "columns": [
            {
                "name": "co_escola",
                "className": "t-codigo-escola"
            },
            {
                "name": "nome_escola",
                "className": "t-nome-escola"
            },
            {
                "name": "situacao_funcionamento",                
                "className": "t-situacao-escola"
            },
            {
                "name": "dependencia_adm",
                "className": "t-dep-adm"
            },
            {
                "name": "ofertas",
                "className": "t-ofertas"
            }
        ],
        createdRow: function (row, data, index) {
            var ofertas = data[4];

            var div = document.createElement('div');
            div.className = "ofertas";

            for (let i = 0; i < ofertas.length; i++) {
                const oferta = ofertas[i];
                
                if (oferta) {
                    var span = document.createElement('span');
                    span.className = "badge badge-pill badge-light";
                    span.textContent = oferta;
                    div.append(span);
                }
                
            }

            $(row).children("td:last-child").html(div);
        }
    });
}


// =======================================================
// HIGHLIGHT
// =======================================================

$(function(){

    var url = window.location.href;
    var id = url.substring(url.lastIndexOf("#") + 1);    

    if (id == "start") {

        $("body").addClass("overlay");
        $('.navbar-busca li:nth-last-of-type(2)').prepend('<span class="highlight"></span>');

    }
	
	$(".highlight").on("click", function(){
		if($("body").hasClass("overlay"))
            $("body").removeClass("overlay");
        $(this).remove();
    });
    
});


// =======================================================
// Funções de Filtro
// =======================================================

function aplicarFiltros(i, str) {
    $('#tabela-escolas').DataTable().columns(i).search(
        str
    ).draw();
}

$(document).on('click', '.filtros-btn-aplicar', function() {

    // Recupera as caixas selecionadas
    var filtrosSituacao = {
        emAtividade: $('#em-atividade').is(':checked') ? true : false,
        paralisada: $('#paralisada').is(':checked') ? true : false,
        extinta: $('#extinta').is(':checked') ? true : false
    };

    var filtrosDepAdm = {
        federal: $('#federal').is(':checked') ? true : false,
        estadual: $('#estadual').is(':checked') ? true : false,
        municipal: $('#municipal').is(':checked') ? true : false,
        privada: $('#privada').is(':checked') ? true : false
    };

    var filtrosOfertas = {
        b: $('#bercario').is(':checked') ? true : false,
        c: $('#creche').is(':checked') ? true : false,
        pe: $('#pre-escola').is(':checked') ? true : false,
        efi: $('#ef-1').is(':checked') ? true : false,
        efii: $('#ef-2').is(':checked') ? true : false,
        emn: $('#ensino-medio').is(':checked') ? true : false,
        emi: $('#ensino-medio-int').is(':checked') ? true : false
    };

    // Atualiza os filtros
    $.ajax({
        url: 'AtualizarFiltros',
        method: 'POST',
        data: {
            atualizarFiltros: "sim",
            filtrosSituacao: JSON.stringify(filtrosSituacao),
            filtrosDepAdm: JSON.stringify(filtrosDepAdm),
            filtrosOfertas: JSON.stringify(filtrosOfertas)
        },
        success: function(retorno) {
            console.log('Success');
            console.log(retorno);
        },
        error: function(retorno) {
            console.log('Error');
            console.log(retorno);
        }
    });

    // Atualiza a tabela
    $('#tabela-escolas').DataTable().draw();

    // Zera os filtros na caixa
    $('#filtros-situacao').html('');
    $('#filtros-dep-adm').html('');
    $('#filtros-ofertas').html('');


    // =======================================================
    // Atualiza a box de filtros
    // =======================================================

    // Situação de Funcionamento
    var vSituacao = Object.values(filtrosSituacao);
    if (vSituacao[0] == true)
        $('#filtros-situacao').append('<span class="badge-light badge-filtro">Em atividade</span>');
    if (vSituacao[1] == true)
        $('#filtros-situacao').append('<span class="badge-light badge-filtro">Paralisada</span>');
    if (vSituacao[2] == true)
        $('#filtros-situacao').append('<span class="badge-light badge-filtro">Extinta</span>');

    // Dependência Administrativa
    var vDep = Object.values(filtrosDepAdm);
    if (vDep[0] == true)
        $('#filtros-dep-adm').append('<span class="badge-light badge-filtro">Federal</span>');
    if (vDep[1] == true)
        $('#filtros-dep-adm').append('<span class="badge-light badge-filtro">Estadual</span>');
    if (vDep[2] == true)
        $('#filtros-dep-adm').append('<span class="badge-light badge-filtro">Municipal</span>');
    if (vDep[3] == true)
        $('#filtros-dep-adm').append('<span class="badge-light badge-filtro">Privada</span>');
    
    // Dependência Administrativa
    var vOfertas = Object.values(filtrosOfertas);
    if (vOfertas[0] == true)
        $('#filtros-ofertas').append('<span class="badge-light badge-filtro">B</span>');
    if (vOfertas[1] == true)
        $('#filtros-ofertas').append('<span class="badge-light badge-filtro">C</span>');
    if (vOfertas[2] == true)
        $('#filtros-ofertas').append('<span class="badge-light badge-filtro">PE</span>');
    if (vOfertas[3] == true)
        $('#filtros-ofertas').append('<span class="badge-light badge-filtro">EFI</span>');
    if (vOfertas[4] == true)
        $('#filtros-ofertas').append('<span class="badge-light badge-filtro">EFII</span>');
    if (vOfertas[5] == true)
        $('#filtros-ofertas').append('<span class="badge-light badge-filtro">EMN</span>');
    if (vOfertas[6] == true)
        $('#filtros-ofertas').append('<span class="badge-light badge-filtro">EMI</span>');

});

$(document).on('click', '.filtros-btn-limpar', function() {

    // Zera os filtros
    var filtrosSituacao = {
        emAtividade: false,
        paralisada: false,
        extinta: false
    };

    var filtrosDepAdm = {
        federal: false,
        estadual: false,
        municipal: false,
        privada: false
    };

    var filtrosOfertas = {
        b: false,
        c: false,
        pe: false,
        efi: false,
        efii: false,
        emn: false,
        emi: false
    };

    // Atualiza os filtros
    $.ajax({
        url: 'AtualizarFiltros',
        method: 'POST',
        data: {
            atualizarFiltros: "sim",
            filtrosSituacao: JSON.stringify(filtrosSituacao),
            filtrosDepAdm: JSON.stringify(filtrosDepAdm),
            filtrosOfertas: JSON.stringify(filtrosOfertas)
        },
        success: function(retorno) {
            console.log('Success');
            console.log(retorno);
        },
        error: function(retorno) {
            console.log('Error');
            console.log(retorno);
        }
    });

    // Atualiza a tabela
    $('#tabela-escolas').DataTable().draw();

    // Zera os filtros na caixa
    $('#filtros-situacao').html('<span class="badge-light badge-filtro">NENHUM</span>');
    $('#filtros-dep-adm').html('<span class="badge-light badge-filtro">NENHUM</span>');
    $('#filtros-ofertas').html('<span class="badge-light badge-filtro">NENHUM</span>');

    // Deseleciona as checkbox
    $('#em-atividade').prop('checked', false);
    $('#paralisada').prop('checked', false);
    $('#extinta').prop('checked', false);
    $('#federal').prop('checked', false);
    $('#estadual').prop('checked', false);
    $('#municipal').prop('checked', false);
    $('#privada').prop('checked', false);
    $('#bercario').prop('checked', false);
    $('#creche').prop('checked', false);
    $('#pre-escola').prop('checked', false);
    $('#ef-1').prop('checked', false);
    $('#ef-2').prop('checked', false);
    $('#ensino-medio').prop('checked', false);
    $('#ensino-medio-int').prop('checked', false);

});

// Para abrir a caixa com os filtros aplicados
$(document).on('click', '.btn-all-filters', function(e) {
    e.stopPropagation();
    toggleNotificacoes();
});


// Função para abrir a caixa com os filtros aplicados
function toggleNotificacoes() {
    var delay = $('.all-filters-box').index() * 50 + 'ms';
    $('.all-filters-box').css({
        '-webkit-transition-delay': delay,
        '-moz-transition-delay': delay,
        '-o-transition-delay': delay,
        'transition-delay': delay
    });
    $(".all-filters-box").toggleClass("active");
}




$(document).ready(function() {

    // Preencher o SELECT do Estado
    $.ajax({
        url: 'RecuperarEstados',
        method: 'POST',
        data: {
            recuperar: "sim"
        },
        datatype: 'html',
        success: function(retorno) {
            // Preenche o SELECT
            $('#select-estado').html(retorno);
        },
        error: function(retorno) {
            console.log('Error');
            console.log(retorno);
        }
    });
    
    // Preencher o SELECT do Município
    $('#select-estado').change(function () {
        
        // Recupera os dados do Estado selecionado
        var dados_estado = $(this).select2('data');
        var estado = dados_estado[0].id;
        var nome_estado = dados_estado[0].text;


        // Recuperar os Municípios
        $.ajax({
            url: 'RecuperarMunicipios',
            method: 'POST',
            data: {
                estado: estado
            },
            datatype: 'html',
            success: function(retorno) {

                // Preenche o SELECT
                $('#select-municipio').html(retorno);
            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });

        // Atualizar o nome na view
        $('.nome-estado').text(nome_estado);

        // Zera o nome do Municipio
        $('.nome-municipio').html('');

        // =======================================================
        // Preencher a tabela
        // =======================================================

        // Limpa e destrói a tabela
        $("#tabela-escolas").DataTable().clear().destroy();

        $('#tabela-escolas').DataTable({
            "language": {
                "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/Portuguese-Brasil.json"
            },
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": 'RecuperarEscolasTabela',
                "type": 'GET',
                "data": {
                    "estado": estado
                }
            },
            "columns": [
                {
                    "name": "co_escola",
                    "className": "t-codigo-escola"
                },
                {
                    "name": "nome_escola",
                    "className": "t-nome-escola"
                },
                {
                    "name": "situacao_funcionamento",                
                    "className": "t-situacao-escola"
                },
                {
                    "name": "dependencia_adm",
                    "className": "t-dep-adm"
                },
                {
                    "name": "ofertas",
                    "className": "t-ofertas"
                }
            ],
            createdRow: function (row, data, index) {
                var ofertas = data[4];
    
                var div = document.createElement('div');
                div.className = "ofertas";
    
                for (let i = 0; i < ofertas.length; i++) {
                    const oferta = ofertas[i];
                    
                    if (oferta) {
                        var span = document.createElement('span');
                        span.className = "badge badge-pill badge-light";
                        span.textContent = oferta;
                        div.append(span);
                    }
                    
                }
    
                $(row).children("td:last-child").html(div);
            }
        });

    });

    // Preencher o SELECT da Escola
    $('#select-municipio').change(function () {
    
        // Recupera os dados do Municipio selecionado
        var dados_municipio = $(this).select2('data');
        var municipio = dados_municipio[0].id;
        var nome_municipio = dados_municipio[0].text;
        
        var estado = $('#select-estado').val();
        
        $.ajax({
            url: 'RecuperarEscolas',
            method: 'POST',
            data: {
                municipio: municipio
            },
            datatype: 'html',
            success: function(retorno) {

                // Preenche o SELECT
                $('#select-escola').html(retorno);
            },
            error: function(retorno) {
                console.log('Error');
                console.log(retorno);
            }
        });

        // Atualizar o nome na view
        $('.nome-municipio').text(nome_municipio);

        
        // =======================================================
        // Preencher a tabela
        // =======================================================

        // Limpa e destrói a tabela
        $("#tabela-escolas").DataTable().clear().destroy();

        $('#tabela-escolas').DataTable({
            "language": {
                "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/Portuguese-Brasil.json"
            },
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": 'RecuperarEscolasTabela',
                "type": 'GET',
                "data": {
                    "estado": estado,
                    "municipio": municipio
                }
            },
            "columns": [
                {
                    "name": "co_escola",
                    "className": "t-codigo-escola"
                },
                {
                    "name": "nome_escola",
                    "className": "t-nome-escola"
                },
                {
                    "name": "situacao_funcionamento",                
                    "className": "t-situacao-escola"
                },
                {
                    "name": "dependencia_adm",
                    "className": "t-dep-escola"
                },
                {
                    "name": "ofertas",
                    "className": "t-ofertas"
                }
            ],
            createdRow: function (row, data, index) {
                var ofertas = data[4];
    
                var div = document.createElement('div');
                div.className = "ofertas";
    
                for (let i = 0; i < ofertas.length; i++) {
                    const oferta = ofertas[i];
                    
                    if (oferta) {
                        var span = document.createElement('span');
                        span.className = "badge badge-pill badge-light";
                        span.textContent = oferta;
                        div.append(span);
                    }
                    
                }
    
                $(row).children("td:last-child").html(div);
            }
        });

    });

    // Criação dos selects
    $("#select-estado").select2({
        placeholder: "Estado"
    });
    $("#select-municipio").select2({
        placeholder: "Município"
    });


    inicializaDataTable(); 

});

// =======================================================
// Controle Cartão Escolas
// =======================================================

$(document).on('click', '#tabela-escolas tbody tr', function(){

    var co_escola = $(this).children("td.t-codigo-escola").text();

    $.ajax({
        url: 'RecuperarInformacoesEscola',
        method: 'POST',
        data: {
            codigoEscola: co_escola        
        },
        datatype: 'html',
        success: function(retorno) {
            $("#modal-escola").html(retorno);
            $("#modal-escola").modal("show");
        },
        error: function(retorno) {
            console.log(retorno);
        }
    })

})


// =======================================================
// Controle dos dropdowns de filtros
// =======================================================

$(document).click(function() {
    $('.filtros-dropdown').addClass('closed');
    $('.filtros-dropdown').removeClass('opened');    
});

$('.filtros-btn-aplicar, .filtros-btn-cancelar').click(function() {
    $('.filtros-dropdown').addClass('closed');
    $('.filtros-dropdown').removeClass('opened');    
});

// Para a propagação do clique dentro do dropdown
$(document).on('click', '.filtros-dropdown', function(e) {
    e.stopPropagation();
});

$(document).on("click", ".btn-filtro", function(e) {
    e.stopPropagation();
    e.preventDefault();

    // Abre o que clicou
    var dropdown = $(this).parent().children('.filtros-dropdown');
    if (dropdown.hasClass('opened')) {        
        dropdown.removeClass('opened');
        dropdown.addClass('closed');
        return;
    }

    // Fecha todos os drop
    $('.filtros-dropdown').addClass('closed');
    $('.filtros-dropdown').removeClass('opened');
    
    dropdown.removeClass('closed');
    dropdown.addClass('opened');
});