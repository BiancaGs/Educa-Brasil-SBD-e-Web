/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.util.Pair;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Escola;
import persistence.DAOException;
import persistence.EscolaDAO;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class RecuperarEscolasTabela extends HttpServlet {


    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String codigoEstado = request.getParameter("estado");
        String codigoMunicipio = request.getParameter("municipio");
        String brasil = request.getParameter("brasil");

        
        try {
        
            EscolaDAO edao = new EscolaDAO();            
            
            /**
            * Manipulação da Sessão
            * - Armazena as variáveis 'co_estado' e 'qtd_escolas_estado' para utilização da tabela
            */

            HttpSession s = request.getSession(true);  // se não existir uma sessão, cria uma
            if ( s.getAttribute("co_estado") != null ) {
                String estadoSessao = (String) s.getAttribute("co_estado");
                // codigo recuperado
                if ( codigoEstado != null && !codigoEstado.equals(estadoSessao) ) { // usuário selecionou um estado diferente
                    // atualiza o codigo e a quantidade
                    s.setAttribute("co_estado", codigoEstado);
                    Integer total = edao.contarEscolasEstado(codigoEstado);
                    s.setAttribute("qtd_escolas_estado", total.toString());
                }

                if ( codigoMunicipio !=  null ) {
                    if ( s.getAttribute("co_municipio") != null ) {
                        String municipioSessao = (String) s.getAttribute("co_municipio");
                        // codigo recuperado
                        if ( !codigoMunicipio.equals(municipioSessao) ) { // usuário selecionou um estado diferente
                            // atualiza o codigo e a quantidade
                            s.setAttribute("co_municipio", codigoMunicipio);
                            Integer total = edao.contarEscolasMunicipio(codigoMunicipio);
                            s.setAttribute("qtd_escolas_municipio", total.toString());
                        }
                    }
                    else {
                        // codigo inexistente
                        s.setAttribute("co_municipio", codigoMunicipio);
                        Integer total = edao.contarEscolasMunicipio(codigoMunicipio);
                        s.setAttribute("qtd_escolas_municipio", total.toString());
                    }
                }
            }
            else {
                // codigo inexistente
                if (codigoEstado != null) {
                    s.setAttribute("co_estado", codigoEstado);
                    Integer total = edao.contarEscolasEstado(codigoEstado);
                    s.setAttribute("qtd_escolas_estado", total.toString());
                }                
            }


            /**
             * Variáveis da requisição de uso da datatable
             */

            String draw = request.getParameter("draw");
            String length = request.getParameter("length");                 // tamanho selecionado para paginação
            String start = request.getParameter("start");                   // início dos itens
            String searchValue = request.getParameter("search[value]");     // valor do campo de busca
            String orderColumn = request.getParameter("order[0][column]");  // coluna em que foi requisitada a ordenação
            String orderDirection = request.getParameter("order[0][dir]");  // direção de ordenação (ASC / DESC)
            
            
            /**
             * Criação do JSON
             */

            String json;
            
            if ( brasil != null && brasil.equals("sim")) {
                json = edao.listaBrasilJSON(searchValue, length, start, draw, "285975", orderColumn, orderDirection, (List<Pair<String, Boolean>>) s.getAttribute("filtros_situacao"), (List<Pair<String, Boolean>>) s.getAttribute("filtros_dependencia_adm"), (List<Pair<String, Boolean>>) s.getAttribute("filtros_ofertas"));
            }
            else {
                if (codigoMunicipio != null) 
                    json = edao.listaPorMunicipioJSON(codigoMunicipio, codigoEstado, searchValue, length, start, draw, (String) s.getAttribute("qtd_escolas_municipio"), 
                            orderColumn, orderDirection, (List<Pair<String, Boolean>>) s.getAttribute("filtros_situacao"), (List<Pair<String, Boolean>>) s.getAttribute("filtros_dependencia_adm"), (List<Pair<String, Boolean>>) s.getAttribute("filtros_ofertas"));
                else
                    json = edao.listarPorEstadoJSON(codigoEstado, searchValue, length, start, draw, (String) s.getAttribute("qtd_escolas_estado"), 
                            orderColumn, orderDirection, (List<Pair<String, Boolean>>) s.getAttribute("filtros_situacao"), (List<Pair<String, Boolean>>) s.getAttribute("filtros_dependencia_adm"), (List<Pair<String, Boolean>>) s.getAttribute("filtros_ofertas"));
            }
            
            
            // Retorno
            response.setStatus(200);
            response.getWriter().write(json);
            

            
        } catch (DAOException ex) {
            Logger.getLogger(RecuperarEscolasTabela.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
