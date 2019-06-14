/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import persistence.ConnectionFactory;
import persistence.DAOException;
import persistence.EstatisticasDAO;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class RecuperarEstatisticas extends HttpServlet {

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
        
        try {
            
            String json = "";
            EstatisticasDAO edao = new EstatisticasDAO();
            
            // Tratamento das requisições das Estatisticas
            if ( request.getParameter("recuperarEstatisticas") != null && request.getParameter("recuperarEstatisticas").equals("sim") ) {
                json = edao.recuperarEstatisticas("sim", "", "", "");
            }
            else if ( request.getParameter("regiao") != null ) {
                String codigoRegiao = request.getParameter("regiao");
                json = edao.recuperarEstatisticas("", codigoRegiao, "", "");
            }
            else if ( request.getParameter("estado") != null ) {
                String codigoEstado = request.getParameter("estado");
                json = edao.recuperarEstatisticas("", "", codigoEstado, "");
            }
            else if ( request.getParameter("municipio") != null ) {
                String codigoMunicipio = request.getParameter("municipio");
                json = edao.recuperarEstatisticas("", "", "", codigoMunicipio);
            }
            
            PrintWriter writer = response.getWriter();
            writer.print(json);
            writer.close();
            
        } catch (DAOException | SQLException ex) {
            Logger.getLogger(RecuperarEstatisticas.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
