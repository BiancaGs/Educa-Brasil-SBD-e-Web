
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
import model.Municipio;
import persistence.DAOException;
import persistence.MunicipioDAO;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class RecuperarMunicipios extends HttpServlet {

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
        
        // Recupera o código do Estado da Requisição
        String estado = request.getParameter("estado");

        try {

            MunicipioDAO mdao = new MunicipioDAO();
            List<Municipio> municipios = mdao.listar(estado);

            for (int i = 0; i < municipios.size(); i++) {
                String option = "<option value='" + municipios.get(i).getCodigo() + "'>" + municipios.get(i).getNome() + "</option>";
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
        return "A partir da seleção de um Estado, retorna as opções de Municípios";
    }

}
