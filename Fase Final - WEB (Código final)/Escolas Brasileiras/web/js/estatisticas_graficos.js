/// <reference path='../lib/jquery/jquery-3.3.1.min.js' />
/// <reference path='../lib/amchats4/core.js' />
/// <reference path='../lib/amchats4/maps.js' />
/// <reference path='../lib/amchats4/charts.js' />
/// <reference path='../lib/amchats4/animated.js' />


// =======================================================
// MAPA PRINCIPAL DA PÁGINA (REGIÃO, ESTADO, MUNICÍPIO)
// =======================================================

// Criar o mapa do Brasil
function criarGraficoPrincipal(json) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	// Create map instance
	var chart = am4core.create("mapa-principal", am4maps.MapChart);

	// Desabilita o zoom
	chart.chartContainer.wheelable = false;
	chart.seriesContainer.events.disableType("doublehit");
	chart.chartContainer.background.events.disableType("doublehit");

	// Desabilitar efeito de arrastar
	chart.seriesContainer.draggable = false;
	chart.seriesContainer.resizable = false;

	// Set map definition
	chart.geodata = am4geodata_brazilHigh;

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

// =======================================================
// Criar o mapa da Região
// =======================================================

function criarMapaRegiao(json, codigoRegiao) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	// Create map instance
	var chart = am4core.create("mapa-principal", am4maps.MapChart);

	// Desabilita o zoom
	chart.chartContainer.wheelable = false;
	chart.seriesContainer.events.disableType("doublehit");
	chart.chartContainer.background.events.disableType("doublehit");

	// Desabilitar efeito de arrastar
	chart.seriesContainer.draggable = false;
	chart.seriesContainer.resizable = false;

	// Set map definition
	chart.geodata = am4geodata_brazilHigh;

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
	

	// =======================================================
	// Exclui os Estados não presentes em cada região
	// =======================================================

	switch (codigoRegiao) {
		case "1": // Norte
			polygonSeries.exclude = ["BR-AL", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-SC", "BR-SP", "BR-SE"];
			break;
		case "2": // Nordeste
			polygonSeries.exclude = ["BR-AC", "BR-AP", "BR-AM", "BR-DF", "BR-ES", "BR-GO", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PR", "BR-RJ", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-TO"];
			break;
		case "3": // Sudeste
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SE", "BR-TO"];
			break;
		case "4": // Sul
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RO", "BR-RR", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "5": // Centro-Oeste
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-ES", "BR-MA", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
	
		default:
			break;
	}


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

// =======================================================
// Criar o mapa do Estado
// =======================================================

function criarMapaEstado(json, codigoEstado) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	// Create map instance
	var chart = am4core.create("mapa-principal", am4maps.MapChart);

	// Desabilita o zoom
	chart.chartContainer.wheelable = false;
	chart.seriesContainer.events.disableType("doublehit");
	chart.chartContainer.background.events.disableType("doublehit");

	// Desabilitar efeito de arrastar
	chart.seriesContainer.draggable = false;
	chart.seriesContainer.resizable = false;

	// Set map definition
	chart.geodata = am4geodata_brazilHigh;

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
	

	// =======================================================
	// Apenas o Estado selecionado
	// =======================================================

	switch (codigoEstado) {
		case "12": // Acre
			polygonSeries.exclude = ["BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "27": // Alagoas
			polygonSeries.exclude = ["BR-AC", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "16": // Amapá
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "13": // Amazonas
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "29": // Bahia
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "23": // Ceará
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "53": // Distrito Federal
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "32": // Espírito Santo
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "52": // Goiás
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "21": // Maranhão
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "51": // Mato Grosso
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "50": // Mato Grosso do Sul
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "31": // Minas Gerais
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "15": // Pará
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "25": // Paraíba
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "41": // Paraná
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "26": // Pernambuco
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "22": // Piauí
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "33": // Rio de Janeiro
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "24": // Rio Grande do Norte
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "43": // Rio Grande do Sul
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "11": // Rondônia
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "14": // Roraima
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "42": // Santa Catarina
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "35": // São Paulo
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SE", "BR-TO"];
			break;
		case "28": // Sergipe
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-TO"];
			break;
		case "17": // Tocantins
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE"];
			break;
	
		default:
			break;
	}


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



function criarMapaMunicipio(json, codigoEstado, nomeMunicipio, latitude, longitude) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	// Create map instance
	var chart = am4core.create("mapa-principal", am4maps.MapChart);

	// Desabilita o zoom
	chart.chartContainer.wheelable = false;
	chart.seriesContainer.events.disableType("doublehit");
	chart.chartContainer.background.events.disableType("doublehit");

	// Desabilitar efeito de arrastar
	chart.seriesContainer.draggable = false;
	chart.seriesContainer.resizable = false;

	// Set map definition
	chart.geodata = am4geodata_brazilHigh;

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
	

	// =======================================================
	// Apenas o Estado selecionado
	// =======================================================

	switch (codigoEstado) {
		case "12": // Acre
			polygonSeries.exclude = ["BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "27": // Alagoas
			polygonSeries.exclude = ["BR-AC", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "16": // Amapá
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "13": // Amazonas
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "29": // Bahia
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "23": // Ceará
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "53": // Distrito Federal
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "32": // Espírito Santo
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "52": // Goiás
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "21": // Maranhão
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "51": // Mato Grosso
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "50": // Mato Grosso do Sul
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "31": // Minas Gerais
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "15": // Pará
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "25": // Paraíba
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "41": // Paraná
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "26": // Pernambuco
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "22": // Piauí
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "33": // Rio de Janeiro
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "24": // Rio Grande do Norte
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "43": // Rio Grande do Sul
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "11": // Rondônia
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RR", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "14": // Roraima
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-SC", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "42": // Santa Catarina
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SP", "BR-SE", "BR-TO"];
			break;
		case "35": // São Paulo
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SE", "BR-TO"];
			break;
		case "28": // Sergipe
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-TO"];
			break;
		case "17": // Tocantins
			polygonSeries.exclude = ["BR-AC", "BR-AL", "BR-AP", "BR-AM", "BR-BA", "BR-CE", "BR-DF", "BR-ES", "BR-GO", "BR-MA", "BR-MT", "BR-MS", "BR-MG", "BR-PA", "BR-PB", "BR-PR", "BR-PE", "BR-PI", "BR-RJ", "BR-RN", "BR-RS", "BR-RO", "BR-RR", "BR-SC", "BR-SP", "BR-SE"];
			break;
	
		default:
			break;
	}


	// Configure series tooltip
	var polygonTemplate = polygonSeries.mapPolygons.template;
	polygonTemplate.tooltipText = "{name}: {value}";
	polygonTemplate.nonScalingStroke = true;
	polygonTemplate.strokeWidth = 0.5;

	// Create hover state and set alternative fill color
	var hs = polygonTemplate.states.create("hover");
	hs.properties.fill = am4core.color("#88bc3c");

	// Cor do tooltip
	polygonSeries.tooltip.getFillFromObject = false;
	polygonSeries.tooltip.background.fill = am4core.color("white");
	polygonSeries.tooltip.autoTextColor = false;
	polygonSeries.tooltip.label.fill = am4core.color("black");

	// Create image series
	var imageSeries = chart.series.push(new am4maps.MapImageSeries());

	// Create image
	var imageSeriesTemplate = imageSeries.mapImages.template;
	var marker = imageSeriesTemplate.createChild(am4core.Image);
	marker.href = "https://s3-us-west-2.amazonaws.com/s.cdpn.io/t-160/marker.svg";
	marker.width = 40;
	marker.height = 40;
	marker.nonScaling = true;
	marker.tooltipText = "{title}";
	marker.horizontalCenter = "middle";
	marker.verticalCenter = "bottom";

	// Set property fields
	imageSeriesTemplate.propertyFields.latitude = "latitude";
	imageSeriesTemplate.propertyFields.longitude = "longitude";

	// Add data for the three cities
	imageSeries.data = [{
		"title": nomeMunicipio,
		"latitude": latitude,
		"longitude": longitude
	}];

}


// =======================================================
// GRÁFICO DE SITUAÇÃO DE FUNCIONAMENTO
// =======================================================

function criarGraficoSituacao(atividade, paralisada, extinta) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	
	// Create chart_situacao instance
	var chart_situacao = am4core.create("grafico-situacao", am4charts.PieChart);
	
	// Add data
	chart_situacao.data = [{
		"nome": "Em Atividade",
		"quantidade": atividade
	}, {
		"nome": "Paralisada",
		"quantidade": paralisada
	}, {
		"nome": "Extinta",
		"quantidade": extinta
	}];
	
	// Add and configure Series
	var situacaoSeries = chart_situacao.series.push(new am4charts.PieSeries());
	situacaoSeries.dataFields.value = "quantidade";
	situacaoSeries.dataFields.category = "nome";
	
	situacaoSeries.ticks.template.disabled = true;
	situacaoSeries.alignLabels = false;
	situacaoSeries.labels.template.text = "{value.percent.formatNumber('#.0')}%";
	situacaoSeries.labels.template.radius = am4core.percent(-40);
	situacaoSeries.labels.template.fill = am4core.color("white");
	
	
	chart_situacao.legend = new am4charts.Legend();
	
	
	// Define as cores
	var colorSet  = new am4core.ColorSet();
	colorSet.list = ["#32BA7C", "#FF8800", "#E21B1B"].map(function(color) {
		return new am4core.color(color);
	});
	situacaoSeries.colors = colorSet;
	
	// Cor do tooltip
	situacaoSeries.tooltip.getFillFromObject = false;
	situacaoSeries.tooltip.background.fill = am4core.color("white");
	situacaoSeries.tooltip.autoTextColor = false;
	situacaoSeries.tooltip.label.fill = am4core.color("black");
	
	// This creates initial animation
	situacaoSeries.hiddenState.properties.opacity = 1;
	situacaoSeries.hiddenState.properties.endAngle = -90;
	situacaoSeries.hiddenState.properties.startAngle = -90;

}




// =======================================================
// GRÁFICO DE DEPENDÊNCIA ADMINISTRATIVA
// =======================================================

function criarGraficoDependencias(federal, estadual, municipal, privada) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	// Create chart_dep_adm instance
	var chart_dep_adm = am4core.create("grafico-dep-adm", am4charts.PieChart);
	
	// Add data
	chart_dep_adm.data = [{
		"nome": "Federal",
		"quantidade": federal
	}, {
		"nome": "Estadual",
		"quantidade": estadual
	}, {
		"nome": "Municipal",
		"quantidade": municipal
	}, {
		"nome": "Privada",
		"quantidade": privada
	}];
	
	// Add and configure Series
	var depAdmSeries = chart_dep_adm.series.push(new am4charts.PieSeries());
	depAdmSeries.dataFields.value = "quantidade";
	depAdmSeries.dataFields.category = "nome";
	
	depAdmSeries.ticks.template.disabled = true;
	depAdmSeries.alignLabels = false;
	depAdmSeries.labels.template.text = "{value.percent.formatNumber('#.0')}%";
	depAdmSeries.labels.template.radius = am4core.percent(-40);
	depAdmSeries.labels.template.fill = am4core.color("white");
	
	
	chart_dep_adm.legend = new am4charts.Legend();
	
	
	// Define as cores
	// var colorSet  = new am4core.ColorSet();
	// colorSet.list = ["#32BA7C", "#FF8800", "#E21B1B"].map(function(color) {
	// 	return new am4core.color(color);
	// });
	// depAdmSeries.colors = colorSet;
	
	// Cor do tooltip
	depAdmSeries.tooltip.getFillFromObject = false;
	depAdmSeries.tooltip.background.fill = am4core.color("white");
	depAdmSeries.tooltip.autoTextColor = false;
	depAdmSeries.tooltip.label.fill = am4core.color("black");
	
	// This creates initial animation
	depAdmSeries.hiddenState.properties.opacity = 1;
	depAdmSeries.hiddenState.properties.endAngle = -90;
	depAdmSeries.hiddenState.properties.startAngle = -90;

}




// =======================================================
// GRÁFICO LOCALIZAÇÃO
// =======================================================

function criarGraficoLocalizacao(urbana, rural) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	
	// Create chart_localizacao instance
	var chart_localizacao = am4core.create("grafico-localizacao", am4charts.PieChart);
	
	// Add data
	chart_localizacao.data = [{
		"nome": "Rural",
		"quantidade": rural
	}, {
		"nome": "Urbana",
		"quantidade": urbana
	}];
	
	// Add and configure Series
	var localizacaoSeries = chart_localizacao.series.push(new am4charts.PieSeries());
	localizacaoSeries.dataFields.value = "quantidade";
	localizacaoSeries.dataFields.category = "nome";
	
	localizacaoSeries.ticks.template.disabled = true;
	localizacaoSeries.alignLabels = false;
	localizacaoSeries.labels.template.text = "{value.percent.formatNumber('#.0')}%";
	localizacaoSeries.labels.template.radius = am4core.percent(-40);
	localizacaoSeries.labels.template.fill = am4core.color("white");
	
	
	chart_localizacao.legend = new am4charts.Legend();
	
	
	// Define as cores
	 var colorSet  = new am4core.ColorSet();;
	 colorSet.list = ["#005c17", "#7d8900"].map(function(color) {
	 	return new am4core.color(color);
	 });
	 localizacaoSeries.colors = colorSet;
	
	// Cor do tooltip
	localizacaoSeries.tooltip.getFillFromObject = false;
	localizacaoSeries.tooltip.background.fill = am4core.color("white");
	localizacaoSeries.tooltip.autoTextColor = false;
	localizacaoSeries.tooltip.label.fill = am4core.color("black");
	
	// This creates initial animation
	localizacaoSeries.hiddenState.properties.opacity = 1;
	localizacaoSeries.hiddenState.properties.endAngle = -90;
	localizacaoSeries.hiddenState.properties.startAngle = -90;


}



// =======================================================
// GRÁFICO OFERTAS DE MATRÍCULA
// =======================================================

function criarGraficoOfertas(b, c, pe, efi, efii, emn, emi) {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	
	// Create chart_oferta instance
	var chart_oferta = am4core.create("grafico-oferta", am4charts.PieChart);
	
	// Add data
	chart_oferta.data = [{
		"nome": "B",
		"quantidade": b
	}, {
		"nome": "C",
		"quantidade": c
	}, {
		"nome": "PE",
		"quantidade": pe
	}, {
		"nome": "EF I",
		"quantidade": efi
	}, {
		"nome": "EF II",
		"quantidade": efii
	}, {
		"nome": "EM",
		"quantidade": emn
	}, {
		"nome": "EMI",
		"quantidade": emi
	}];
	
	// Add and configure Series
	var ofertaSeries = chart_oferta.series.push(new am4charts.PieSeries());
	ofertaSeries.dataFields.value = "quantidade";
	ofertaSeries.dataFields.category = "nome";
	
	ofertaSeries.ticks.template.disabled = true;
	ofertaSeries.alignLabels = false;
	ofertaSeries.labels.template.text = "{value.percent.formatNumber('#.0')}%";
	ofertaSeries.labels.template.radius = am4core.percent(-40);
	ofertaSeries.labels.template.fill = am4core.color("white");
	
	
	chart_oferta.legend = new am4charts.Legend();
	
	
	// Define as cores
//	 var colorSet  = new am4core.ColorSet();;
//	 colorSet.list = ["#17005c", "#630062", "#9b005d", "#c80050", "#e83f3e", "#fb7327", "#ffa600"].map(function(color) {
//	 	return new am4core.color(color);
//	 });
//	 ofertaSeries.colors = colorSet;
	
	// Cor do tooltip
	ofertaSeries.tooltip.getFillFromObject = false;
	ofertaSeries.tooltip.background.fill = am4core.color("white");
	ofertaSeries.tooltip.autoTextColor = false;
	ofertaSeries.tooltip.label.fill = am4core.color("black");
	
	// This creates initial animation
	ofertaSeries.hiddenState.properties.opacity = 1;
	ofertaSeries.hiddenState.properties.endAngle = -90;
	ofertaSeries.hiddenState.properties.startAngle = -90;

}
