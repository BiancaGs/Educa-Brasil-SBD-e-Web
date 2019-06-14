/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import persistence.DAOException;

import persistence.EscolaDAO;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class RecuperarQuantidadeEscolasEstado extends HttpServlet {

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
        
        if ( request.getParameter("recuperarIndex") != null && request.getParameter("recuperarIndex").equals("sim") ) {
            
            try {
                
                EscolaDAO edao = new EscolaDAO();
                String json = edao.recuperarQtdEscolas();
                
                PrintWriter writer = response.getWriter();
                writer.print(json);
                writer.close();
                
            } catch (DAOException | SQLException ex) {
                Logger.getLogger(RecuperarQuantidadeEscolasEstado.class.getName()).log(Level.SEVERE, null, ex);
            }
            
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
