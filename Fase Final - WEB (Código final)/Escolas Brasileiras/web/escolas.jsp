<%-- 
    Document   : escolas
    Created on : 13/05/2019, 10:03:21
    Author     : Pietro
    Author     : Bianca
--%>

<%@page import="javafx.util.Pair"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.Estado"%>
<%@page import="persistence.EstadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="cabecalho.html"%>

    <%
        // Cria uma sessão caso não exista
        session = request.getSession(true);
 
        // Valores default para os filtros
        List<Pair<String, Boolean>> filtrosSituacao = new ArrayList<>();
        filtrosSituacao.add(new Pair("Em atividade", false));
        filtrosSituacao.add(new Pair("Paralisada", false));
        filtrosSituacao.add(new Pair("Extinta", false));
        session.setAttribute("filtros_situacao", filtrosSituacao);
        
        List<Pair<String, Boolean>> filtrosDep = new ArrayList<>();
        filtrosDep.add(new Pair("Federal", false));
        filtrosDep.add(new Pair("Estadual", false));
        filtrosDep.add(new Pair("Municipal", false));
        filtrosDep.add(new Pair("Privada", false));
        session.setAttribute("filtros_dependencia_adm", filtrosDep);
        
        List<Pair<String, Boolean>> filtrosOfertas = new ArrayList<>();
        filtrosOfertas.add(new Pair("bercario", false));
        filtrosOfertas.add(new Pair("creche", false));
        filtrosOfertas.add(new Pair("pre_escola", false));
        filtrosOfertas.add(new Pair("ens_fundamental_anos_iniciais", false));
        filtrosOfertas.add(new Pair("ens_fundamental_anos_finais", false));
        filtrosOfertas.add(new Pair("ens_medio_normal", false));
        filtrosOfertas.add(new Pair("ens_medio_integrado", false));
        session.setAttribute("filtros_ofertas", filtrosOfertas);

    %>

    <!-- Header -->
    <header id="header-principal">

        <!-- Barra de Navegação de Busca -->
        <section id="busca">

            <div class="container">
                <ul class="list-inline navbar-busca">
                    <li class="list-inline-item"><a href="escolas.jsp" class="text-success">Brasil</a></li>
                    <li class="list-inline-item">
                        <select name="select-estado" id="select-estado">
                            <!-- Preenchido com AJAX -->
                        </select>
                    </li>
                    <li class="list-inline-item">
                        <select name="select-municipio" id="select-municipio">
                            <option></option>
                            <!-- Preenchido com AJAX -->
                        </select>
                    </li>
                </ul>
            </div>

        </section>

        <section id="secao-filtros">

            <div class="container">

                <ul class="filtros d-flex flex-column flex-sm-row">

                    <li class="filtro">
                        <button type="button" class="btn-filtro">
                            <span class="filtro-nome">Situação de Funcionamento</span>
                            <li-icon>
                                <i class="fas fa-caret-down fa-lg"></i>
                            </li-icon>
                        </button>
                        <div class="filtros-dropdown closed">
                            <fieldset>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="em-atividade">
                                    <label class="custom-control-label" for="em-atividade">Em Atividade</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="paralisada">
                                    <label class="custom-control-label" for="paralisada">Paralisada</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="extinta">
                                    <label class="custom-control-label" for="extinta">Extinta</label>
                                </div>
                                <div class="filtros-botoes">
                                    <button class="filtros-btn-cancelar">Fechar</button>
                                    <button class="filtros-btn-aplicar">Aplicar</button>
                                </div>
                            </fieldset>
                        </div>
                    </li>

                    <li class="filtro">
                        <button type="button" class="btn-filtro">
                            <span class="filtro-nome">Dependência Administrativa</span>
                            <li-icon>
                                <i class="fas fa-caret-down fa-lg"></i>
                            </li-icon>
                        </button>
                        <div class="filtros-dropdown closed">
                            <fieldset>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="federal">
                                    <label class="custom-control-label" for="federal">Federal</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="estadual">
                                    <label class="custom-control-label" for="estadual">Estadual</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="municipal">
                                    <label class="custom-control-label" for="municipal">Municipal</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="privada">
                                    <label class="custom-control-label" for="privada">Privada</label>
                                </div>
                                <div class="filtros-botoes">
                                    <button class="filtros-btn-cancelar">Fechar</button>
                                    <button class="filtros-btn-aplicar">Aplicar</button>
                                </div>
                            </fieldset>
                        </div>
                    </li>

                    <li class="filtro">
                        <button type="button" class="btn-filtro">
                            <span class="filtro-nome">Ofertas de Matrícula</span>
                            <li-icon>
                                <i class="fas fa-caret-down fa-lg"></i>
                            </li-icon>
                        </button>
                        <div class="filtros-dropdown closed">
                            <fieldset>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="bercario">
                                    <label class="custom-control-label" for="bercario">Bercário</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="creche">
                                    <label class="custom-control-label" for="creche">Creche</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="pre-escola">
                                    <label class="custom-control-label" for="pre-escola">Pré Escola</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="ef-1">
                                    <label class="custom-control-label" for="ef-1">Ensino Fundamental - 1º ao 4º</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="ef-2">
                                    <label class="custom-control-label" for="ef-2">Ensino Fundamental - 5º ao 8º</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="ensino-medio">
                                    <label class="custom-control-label" for="ensino-medio">Ensino Médio Normal</label>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="ensino-medio-int">
                                    <label class="custom-control-label" for="ensino-medio-int">Ensino Médio
                                        Integrado</label>
                                </div>
                                <div class="filtros-botoes">
                                    <button class="filtros-btn-cancelar">Fechar</button>
                                    <button class="filtros-btn-aplicar">Aplicar</button>
                                </div>
                            </fieldset>
                        </div>
                    </li>

                    <li class="all-filters">
                        <a role="button" class="btn-all-filters">
                            <i class="fas fa-filter fa-lg"></i>
                        </a>
                        <div class="all-filters-box">
                            <p class="verde-claro-text">Situação de Funcionamento</p>
                            <div id="filtros-situacao">
                                <span class="badge-light badge-filtro">NENHUM</span>
                            </div>
                            <p class="verde-claro-text">Dependência Administrativa</p>
                            <div id="filtros-dep-adm">
                                <span class="badge-light badge-filtro">NENHUM</span>
                            </div>
                            <p class="verde-claro-text">Ofertas de Matrícula</p>
                            <div id="filtros-ofertas">
                                <span class="badge-light badge-filtro">NENHUM</span>
                            </div>
                            <button class="filtros-btn-limpar">limpar filtros</button>
                        </div>
                    </li>

                </ul>

            </div>

        </section>

    </header>

    <!-- Main -->
    <main id="main-principal">

        <div class="container mt-5" id="resultado-busca">

            <h2 class="verde-escuro-text titulo-resultado-busca">Resultado da Busca:</h2>
            <h3 class="verde-claro-text nome-estado">Brasil</h3>
            <h4 class="verde-claro-text mt-4 nome-municipio"></h4>
            
            
            <!-- Escolas -->
            <section id="resultado-escolas" class="mt-4">

                <!-- Tabela de Escolas -->
                <div class="table-responsive-md">
                    <table class="table table-hover" id="tabela-escolas">
                        
                        <thead class="thead-light">
                            <tr>
                                <th class="t-codigo">Código</th>
                                <th class="t-nome">Nome</th>
                                <th class="t-situacao">Situação</th>
                                <th class="t-dep-adm">Dep.Adm.</th>
                                <th class="t-ofertas">Ofertas</th>
                            </tr>
                        </thead>
    
                    </table>
                </div>
                <!-- Fim da Tabela de Escolas -->
                
            </section>
            <!-- Fim Escolas -->

            <!-- Modal Informações Escolas -->
            <div class="modal fade" id="modal-escola" tabindex="-1" role="dialog" aria-labelledby="modal-escola" aria-hidden="true">
                <!-- Completado com requisição -->
            </div>
            <!-- Modal Informações Escolas -->

        </div>
        <!-- Fim do Container -->

    </main>

<%@include file="rodape.html"%>

<script src="lib/mdbootstrap/js/datatables.js"></script>
<script src="lib/select2/js/select2.js"></script>
<script src="js/escolas.js"></script>