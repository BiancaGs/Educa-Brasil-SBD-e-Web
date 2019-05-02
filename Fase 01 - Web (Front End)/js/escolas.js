
// =======================================================
// Função para iniciar/reinicializar a DataTable
// =======================================================

function inicializaDataTable() {
    $('#tabela-escolas').DataTable({
        "language": {
            "lengthMenu": "Mostrar _MENU_ itens por página",
            "zeroRecords": "Nenhum item encontrado - desculpa",
            "info": "Mostrando página _PAGE_ de _PAGES_",
            "infoEmpty": "Nenhum item encontrado",
            "infoFiltered": "(filtrado a partir de _MAX_ itens)",
            "search": "Buscar:",
            "emptyTable":     "Nenhum dado disponível na tabela",
            "loadingRecords": "Carregando...",
            "processing":     "Processando...",
            "paginate": {
                "first":      "Primeiro",
                "last":       "Último",
                "next":       "Próximo",
                "previous":   "Anterior"
            }
        },
        "order": [[ 1, "asc" ]]    // Ordena por Nome
    });
    $('.dataTables_length').addClass('bs-select');
}

$(document).ready(function() {

    // Criação dos selects
    $("#select-estado").select2({
        placeholder: "Estado"
    });
    $("#select-municipio").select2({
        placeholder: "Município"
    });
    $("#select-escola").select2({
        placeholder: "Escola"
    });


    inicializaDataTable(); 

});