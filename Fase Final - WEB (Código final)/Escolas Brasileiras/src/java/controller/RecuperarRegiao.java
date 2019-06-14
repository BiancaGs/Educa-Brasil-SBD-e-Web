/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Regiao;
import persistence.DAOException;
import persistence.RegiaoMesoMicroDistritoDAO;

/**
 *
 * @author Pietro
 * @author Bianca
 * 
 */
public class RecuperarRegiao extends HttpServlet {

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
        
        if( request.getParameter("recuperarRegioes") != null && request.getParameter("recuperarRegioes").equals("sim") ){
            
            String retorno = "<option></option>";
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            
            try {
                
                RegiaoMesoMicroDistritoDAO rdao = new RegiaoMesoMicroDistritoDAO();
                List<Regiao> regioes = rdao.recuperarRegioes();
                        
                for(int i = 0; i < regioes.size(); i++){
                    String option = "<option value='" + regioes.get(i).getCodigo() + "'>" + regioes.get(i).getNome() + "</option>";
                    retorno += option;
                }        
                        
                
            } catch (SQLException | DAOException ex) {
                Logger.getLogger(RecuperarRegiao.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            PrintWriter writer = response.getWriter();
            writer.print(retorno);
            writer.close();
                    
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Este servlet tem o objetivo de recuperar as Regioes disponíveis no Banco de Dados";
    }
}
