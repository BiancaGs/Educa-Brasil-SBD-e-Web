$(document).ready(function() {

    // Recupera a quantidade de escolas por Estado
    $.ajax({
        url: 'RecuperarQuantidadeEscolasEstado',
        method: 'POST',
        data: {
            recuperarIndex: "sim"
        },
        datatype: '',
        success: function(retorno) {

            // Cria o mapa com os dados do json de retorno
            var json = $.parseJSON(retorno);
            criarMapa(json);
            
        },
        error: function(retorno) {
            console.log('Error');
            console.log(retorno);
        }
    });
    


});


// =======================================================
// Função para criar o mapa
// =======================================================

function criarMapa(json) {

    // Themes begin
    am4core.useTheme(am4themes_animated);
    // Themes end

    // Create map instance
    var chart = am4core.create("grafico-brasil", am4maps.MapChart);

    // Desabilita o zoom
    chart.chartContainer.wheelable = false;
    chart.seriesContainer.events.disableType("doublehit");
    chart.chartContainer.background.events.disableType("doublehit");

    // Desabilitar efeito de arrastar
    chart.seriesContainer.draggable = false;
    chart.seriesContainer.resizable = false;

    // Set map definition
    chart.geodata = am4geodata_brazilLow;

    // Create map polygon series

    var polygonSeries = chart.series.push(new am4maps.MapPolygonSeries());

    chart.colors.list = [
        am4core.color("#88BC3C")
    ];


    //Set min/max fill color for each area
    polygonSeries.heatRules.push({
        property: "fill",
        target: polygonSeries.mapPolygons.template,
        min: chart.colors.getIndex(1).brighten(1),
        max: chart.colors.getIndex(1).brighten(-0.3)
    });

    // Make map load polygon data (state shapes and names) from GeoJSON
    polygonSeries.useGeodata = true;

    
    // =======================================================
    // Preenche com os dados do JSON
    // =======================================================

    polygonSeries.data = [];
    for (let i = 0; i < json.length; i++) {
        polygonSeries.data.push({
            id: "BR-" + json[i].sigla,
            value: json[i].qtd 
        });
    }


    // Set up heat legend
    let heatLegend = chart.createChild(am4maps.HeatLegend);
    heatLegend.series = polygonSeries;
    heatLegend.align = "right";
    heatLegend.valign = "bottom";
    heatLegend.width = am4core.percent(25);
    heatLegend.marginRight = am4core.percent(4);
    heatLegend.minValue = 0;
    heatLegend.maxValue = 286015;

    // Set up custom heat map legend labels using axis ranges
    var minRange = heatLegend.valueAxis.axisRanges.create();
    minRange.value = heatLegend.minValue;
    minRange.label.text = "Poucas";
    var maxRange = heatLegend.valueAxis.axisRanges.create();
    maxRange.value = heatLegend.maxValue;
    maxRange.label.text = "Muitas";

    // Blank out internal heat legend value axis labels
    heatLegend.valueAxis.renderer.labels.template.adapter.add("text", function (labelText) {
        return "";
    });

    // Configure series tooltip
    var polygonTemplate = polygonSeries.mapPolygons.template;
    polygonTemplate.tooltipText = "{name}: {value}";
    polygonTemplate.nonScalingStroke = true;
    polygonTemplate.strokeWidth = 0.5;

    // Create hover state and set alternative fill color
    var hs = polygonTemplate.states.create("hover");
    hs.properties.fill = am4core.color("#002776");

    // Cor do tooltip
    polygonSeries.tooltip.getFillFromObject = false;
    polygonSeries.tooltip.background.fill = am4core.color("white");
    polygonSeries.tooltip.autoTextColor = false;
    polygonSeries.tooltip.label.fill = am4core.color("black");

}