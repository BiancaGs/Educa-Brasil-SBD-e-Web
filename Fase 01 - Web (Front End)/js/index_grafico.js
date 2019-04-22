/**
 * ---------------------------------------
 * This demo was created using amCharts 4.
 * 
 * For more information visit:
 * https://www.amcharts.com/
 * 
 * Documentation is available at:
 * https://www.amcharts.com/docs/v4/
 * ---------------------------------------
 */

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

// Set heatmap values for each state
polygonSeries.data = [
    {
        id: "BR-AC",
        value: 10000
    },
    {
        id: "BR-AL",
        value: 20000
    },
    {
        id: "BR-AP",
        value: 30000
    },
    {
        id: "BR-AM",
        value: 40000
    },
    {
        id: "BR-BA",
        value: 50000
    },
    {
        id: "BR-CE",
        value: 60000
    },
    {
        id: "BR-DF",
        value: 70000
    },
    {
        id: "BR-ES",
        value: 80000
    },
    {
        id: "BR-GO",
        value: 90000
    },
    {
        id: "BR-MA",
        value: 100000
    },
    {
        id: "BR-MT",
        value: 110000
    },
    {
        id: "BR-MS",
        value: 120000
    },
    {
        id: "BR-MG",
        value: 130000
    },
    {
        id: "BR-PA",
        value: 140000
    },
    {
        id: "BR-PB",
        value: 150000
    },
    {
        id: "BR-PR",
        value: 160000
    },
    {
        id: "BR-PE",
        value: 170000
    },
    {
        id: "BR-PI",
        value: 180000
    },
    {
        id: "BR-RJ",
        value: 190000
    },
    {
        id: "BR-RN",
        value: 200000
    },
    {
        id: "BR-RS",
        value: 210000
    },
    {
        id: "BR-RO",
        value: 220000
    },
    {
        id: "BR-RR",
        value: 230000
    },
    {
        id: "BR-SC",
        value: 240000
    },
    {
        id: "BR-SP",
        value: 250000
    },
    {
        id: "BR-SE",
        value: 260000
    },
    {
        id: "BR-TO",
        value: 270000
    }
];


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
maxRange.label.text = "Muitas!";

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
hs.properties.fill = am4core.color("#36923F");

// Cor do tooltip
polygonSeries.tooltip.getFillFromObject = false;
polygonSeries.tooltip.background.fill = am4core.color("white");
polygonSeries.tooltip.autoTextColor = false;
polygonSeries.tooltip.label.fill = am4core.color("black");