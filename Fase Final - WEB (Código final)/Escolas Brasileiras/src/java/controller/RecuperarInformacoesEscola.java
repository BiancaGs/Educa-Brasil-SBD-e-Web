/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Escola;
import persistence.DAOException;
import persistence.EscolaDAO;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class RecuperarInformacoesEscola extends HttpServlet {

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
           
        String codigoEscola = request.getParameter("codigoEscola");
        
        try {
            
            EscolaDAO edao = new EscolaDAO();
            Escola e = edao.recuperarEscola(codigoEscola);
            
            RequestDispatcher rd = null;
            rd = request.getRequestDispatcher("./modal-escola.jsp");
            request.setAttribute("escola", e);
            rd.forward(request, response);
            
        } catch (DAOException ex) {
            Logger.getLogger(RecuperarInformacoesEscola.class.getName()).log(Level.SEVERE, null, ex);
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
    }// </editor-fold>

}
