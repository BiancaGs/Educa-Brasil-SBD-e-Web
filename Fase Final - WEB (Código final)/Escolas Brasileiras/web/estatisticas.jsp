<%-- 
    Document   : estatisticas
    Created on : 13/05/2019, 10:03:56
    Author     : Pietro
    Author     : Bianca
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="cabecalho.html"%>

    <!-- Header -->
    <header id="header-principal">

        <!-- Barra de Navegação de Busca -->
        <div id="busca">

            <div class="container">
                <ul class="list-inline navbar-busca">
                    <li class="list-inline-item"><a href="estatisticas.jsp" class="text-success">Brasil</a></li>
                    <li class="list-inline-item">
                        <select name="select-regiao" id="select-regiao">
                            <!-- Preenchido com AJAX -->
                        </select>
                    </li>
                    <li class="list-inline-item">
                        <select name="select-estado" id="select-estado">
                            <!-- Preenchido com AJAX -->
                        </select>
                    </li>
                    <li class="list-inline-item">
                        <select name="select-municipio" id="select-municipio">
                            <!-- Preenchido com AJAX -->
                        </select>
                    </li>
                </ul>
            </div>

        </div>

    </header>

    <!-- Main -->
    <main id="main-principal">

        <div class="container mt-4" id="nav-mapa">
            
            <!-- Breadcrumb de Localização -->
            <nav aria-label="breadcrumb" id="nav-estatisticas">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active">Brasil</li>
                </ol>
            </nav>
            <span class="titulo-qtd-escolas">Número de Escolas: <span class="qtd-escolas"></span></span>

            <!-- Container para o Mapa -->
            <div class="container" id="container-mapa-principal">
                <!-- <div class="row"> -->
                    <div class="mapa-wrapper">
                        <div id="mapa-principal"></div>
                    </div>
                    <!-- <div class="col-sm-6 barras-wrapper">
                        
                    </div> -->
                <!-- </div> -->
            </div>

        </div>

        <div class="container" id="estatisticas-gerais">
            <div class="row">
                <div class="col-sm-6">
                    <h5 class="verde-claro-text">Situação de Funcionamento</h5>
                    <div class="grafico-est" id="grafico-situacao"></div>
                </div>
                <div class="col-sm-6">
                    <h5 class="verde-claro-text">Dependência Administrativa</h5>
                    <div class="grafico-est" id="grafico-dep-adm"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <h5 class="verde-claro-text">Localização</h5>
                    <div class="grafico-est" id="grafico-localizacao"></div>
                </div>
                <div class="col-sm-6">
                    <h5 class="verde-claro-text">Oferta de Matrícula</h5>
                    <div class="grafico-est" id="grafico-oferta"></div>
                </div>
            </div>
        </div>

    </main>

<%@include file="rodape.html"%>

<!-- Amcharts v4.0 -->
<script src="lib/amchats4/core.js"></script>
<script src="lib/amchats4/maps.js"></script>
<script src="lib/amchats4/geodata/brazilLow.js"></script>
<script src="lib/amchats4/geodata/brazilHigh.js"></script>
<script src="lib/amchats4/charts.js"></script>
<script src="lib/amchats4/animated.js"></script>
<script src="lib/select2/js/select2.js"></script>
<script src="js/estatisticas_graficos.js"></script>
<script src="js/estatisticas.js"></script>