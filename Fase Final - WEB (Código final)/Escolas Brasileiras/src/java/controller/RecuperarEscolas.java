package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class RecuperarEscolas extends HttpServlet {

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
        
        String retorno = "<option></option>";
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Recupera o Município da Requisição
        String municipio = request.getParameter("municipio");

        try {

            EscolaDAO edao = new EscolaDAO();
            List<Escola> escolas = edao.listar(municipio);

            for (int i = 0; i < escolas.size(); i++) {
                String option = "<option value='" + escolas.get(i).getCodigo() + "'>" + escolas.get(i).getNome() + "</option>";
                retorno += option;
            }

        } catch (DAOException ex) {
            Logger.getLogger(RecuperarEstados.class.getName()).log(Level.SEVERE, null, ex);
        }

        PrintWriter writer = response.getWriter();
        writer.print(retorno);
        writer.close();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Este servlet tem o objetivo de recuperar as Escolas disponíveis no Banco de Dados dado um Estado e Município";
    }

}
