
// =======================================================
// GRÁFICO DE SITUAÇÃO DE FUNCIONAMENTO
// =======================================================

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart_situacao instance
var chart_situacao = am4core.create("grafico-situacao", am4charts.PieChart);

// Add data
chart_situacao.data = [{
	"nome": "Em Atividade",
	"quantidade": 183708
}, {
	"nome": "Paralisada",
	"quantidade": 42505
}, {
	"nome": "Extinta",
	"quantidade": 59762
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



// =======================================================
// GRÁFICO DE DEPENDÊNCIA ADMINISTRATIVA
// =======================================================

// Create chart_dep_adm instance
var chart_dep_adm = am4core.create("grafico-dep-adm", am4charts.PieChart);

// Add data
chart_dep_adm.data = [{
	"nome": "Federal",
	"quantidade": 795
}, {
	"nome": "Estadual",
	"quantidade": 37746
}, {
	"nome": "Municipal",
	"quantidade": 181459
}, {
	"nome": "Privada",
	"quantidade": 65975
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


// =======================================================
// GRÁFICO LOCALIZAÇÃO
// =======================================================

// Create chart_localizacao instance
var chart_localizacao = am4core.create("grafico-localizacao", am4charts.PieChart);

// Add data
chart_localizacao.data = [{
	"nome": "Rural",
	"quantidade": 123860
}, {
	"nome": "Urbana",
	"quantidade": 162115
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
// var colorSet  = new am4core.ColorSet();
// colorSet.list = ["#32BA7C", "#FF8800", "#E21B1B"].map(function(color) {
// 	return new am4core.color(color);
// });
// localizacaoSeries.colors = colorSet;

// Cor do tooltip
localizacaoSeries.tooltip.getFillFromObject = false;
localizacaoSeries.tooltip.background.fill = am4core.color("white");
localizacaoSeries.tooltip.autoTextColor = false;
localizacaoSeries.tooltip.label.fill = am4core.color("black");

// This creates initial animation
localizacaoSeries.hiddenState.properties.opacity = 1;
localizacaoSeries.hiddenState.properties.endAngle = -90;
localizacaoSeries.hiddenState.properties.startAngle = -90;


// =======================================================
// GRÁFICO OFERTAS DE MATRÍCULA
// =======================================================

// Create chart_oferta instance
var chart_oferta = am4core.create("grafico-oferta", am4charts.PieChart);

// Add data
chart_oferta.data = [{
	"nome": "C",
	"quantidade": 69096
}, {
	"nome": "PE",
	"quantidade": 102465
}, {
	"nome": "EF I",
	"quantidade": 110280
}, {
	"nome": "EF II",
	"quantidade": 61771
}, {
	"nome": "EM",
	"quantidade": 1070
}, {
	"nome": "EMI",
	"quantidade": 1982
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
// var colorSet  = new am4core.ColorSet();
// colorSet.list = ["#32BA7C", "#FF8800", "#E21B1B"].map(function(color) {
// 	return new am4core.color(color);
// });
// ofertaSeries.colors = colorSet;

// Cor do tooltip
ofertaSeries.tooltip.getFillFromObject = false;
ofertaSeries.tooltip.background.fill = am4core.color("white");
ofertaSeries.tooltip.autoTextColor = false;
ofertaSeries.tooltip.label.fill = am4core.color("black");

// This creates initial animation
ofertaSeries.hiddenState.properties.opacity = 1;
ofertaSeries.hiddenState.properties.endAngle = -90;
ofertaSeries.hiddenState.properties.startAngle = -90;