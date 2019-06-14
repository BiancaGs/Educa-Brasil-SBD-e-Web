<%-- 
    Document   : index
    Created on : 13/05/2019, 10:01:07
    Author     : Pietro
    Author     : Bianca
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="css/arrow-bounce.css">

<%@include file="cabecalho.html"%>
        
        <!-- Header -->
        <header id="header-principal">
            
            
        </header>
        
        <!-- Main -->
        <main id="main-principal">
            
            <!-- Hero -->
            <section id="hero-principal">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12 col-md-7 col-lg-5">
                            <h1 class="titulo-principal">Todas as escolas em um só lugar.</h1>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-7 col-lg-5">
                            <p class="paragrafo-principal">O sistema do Educa Brasil é especialista em te auxiliar a encontrar uma escola ideal para as suas necessidades.</p>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-8 col-sm-6 col-lg-4 d-flex flex-column">
                            <span for="btn-start">Vamos começar?</span>
                            <a href="escolas.jsp#start" id="btn-start" class="z-depth-2 mt-3">Encontre sua escola!</a>
                        </div>
                    </div>
                </div>
                <a href="index.jsp#sobre" class="btn-scroll">
                    <div class="arrow bounce"><i class="fa fa-angle-down dark-grey-text fa-5x" aria-hidden="true" style="position: absolute; bottom: 5px;"></i></div>
                </a>
            </section>

            <!-- Sobre o Site -->
            <section id="sobre">

                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-12 col-md-8">
                            <h2 class="verde-escuro-text semibold">Escolha a melhor escola à partir de dados do Censo Escolar do Inep</h2>
                        </div>
                    </div>
                    <div class="row justify-content-center mt-2">
                        <div class="col-12 col-md-8">
                            <p>Os dados do Educa Brasil vêm do Censo Escolar dos <a href="http://inep.gov.br/microdados" class="text-success">Microdados do Inep</a> 2018 e abrangem diversas informações que permitem encontrar a melhor escola possível</p>
                        </div>
                    </div>
                    <div class="row caracteristicas">

                        <div class="col-12 col-sm-4 col-md-4">
                            <div class="img rounded-circle situacao"></div>
                            <p>Situação de Funcionamento</p>
                        </div>
                        <div class="col-12 col-sm-4 col-md-4">
                            <div class="img rounded-circle dependencias"></div>
                            <p>Dependências da Escola</p>
                        </div>
                        <div class="col-12 col-sm-4 col-md-4">
                            <div class="img rounded-circle ofertas-matricula"></div>
                            <p>Ofertas de Matrícula</p>
                        </div>

                    </div>
                </div>

            </section>

            <!-- Sobre Estatísticas -->
            <section id="sobre-estatisticas">
                <div class="container">
                    <div class="row">
                        <div class="col-12 col-lg-5">
                            <h2 class="verde-escuro-text semibold">Consulte as estatísticas gerais dos dados das escolas</h2>
                            <p>O sistema do Educa Brasil permite que você visualize os dados gerais das escolas brasileiras à partir de gráficos personalizados com diversas informações.</p>
                        </div>
                        <div class="col-12 col-lg-7">
                            <div id="grafico-brasil"></div>
                        </div>
                    </div>
                </div>
                
            </section>

        </main>
    
<%@include file="rodape.html"%>

<script src="js/index.js"></script>
<!-- Amcharts v4.0 -->
<script src="lib/amchats4/core.js"></script>
<script src="lib/amchats4/maps.js"></script>
<script src="lib/amchats4/geodata/brazilLow.js"></script>
<script src="lib/amchats4/animated.js"></script>
<script src="js/index_grafico.js"></script>