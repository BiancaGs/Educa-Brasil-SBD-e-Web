
package persistence;

import model.Estado;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Pietro
 * @author Bianca
 * 
 */
public class EstadoDAO {
   
    private Connection connection;

    public EstadoDAO() throws DAOException {
        this.connection = ConnectionFactory.getConnection();
    }
    
    /**
     * Recupera todos os Estados
     * 
     * @return uma List de Estado
     */
    public List<Estado> listar() {
        
        List<Estado> estados = new ArrayList<>();
        
        try {
        
            String sql = "SELECT * FROM uf ORDER BY nome_uf";
            PreparedStatement stmt = connection.prepareStatement(sql);
        
            ResultSet rs = stmt.executeQuery();
        
            while (rs.next()) {
                Estado e = new Estado();
                e.setCodigo(rs.getInt("co_uf"));
                e.setNome(rs.getString("nome_uf"));
                e.setSigla(rs.getString("sigla_uf"));
                
                estados.add(e);
            }
        
        } catch (SQLException ex) {
            Logger.getLogger(EstadoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return estados;
        
    }
    
    /**
     * Recupera todos os Estados dado o código de uma Região
     * 
     * @param codigoRegiao
     * @return 
     */
    public List<Estado> listarEstadoRegiao( String codigoRegiao) {
        
        List<Estado> estados = new ArrayList<>();
        
        try {
        
            String sql = "SELECT * FROM uf WHERE co_regiao = "+ codigoRegiao + "ORDER BY nome_uf" ;
            PreparedStatement stmt = connection.prepareStatement(sql);
        
            ResultSet rs = stmt.executeQuery();
        
            while (rs.next()) {
                Estado e = new Estado();
                e.setCodigo(rs.getInt("co_uf"));
                e.setNome(rs.getString("nome_uf"));
                e.setSigla(rs.getString("sigla_uf"));
                
                estados.add(e);
            }
        
        } catch (SQLException ex) {
            Logger.getLogger(EstadoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return estados;
        
    }
    
    
    /**
     * Recupera os dados de um Estado dado seu código
     * 
     * @param codigo
     * @return o Estado
     */
    public Estado buscar(String codigo) {
        
        Estado e = new Estado();
        
        try {
            
            String sql = "SELECT * FROM uf WHERE co_uf = " + codigo;
            PreparedStatement stmt = connection.prepareStatement(sql);
        
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                e.setCodigo(rs.getInt("co_uf"));
                e.setNome(rs.getString("nome_uf"));
                e.setSigla(rs.getString("sigla_uf"));
                e.setCodigoRegiao(rs.getInt("co_regiao"));
            }            
        
        } catch (SQLException ex) {
            Logger.getLogger(EstadoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return e;
        
    }
    
}
