/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Distrito;
import model.Mesorregiao;
import model.Microrregiao;
import model.Regiao;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class RegiaoMesoMicroDistritoDAO {
    
    private Connection connection;

    public RegiaoMesoMicroDistritoDAO() throws DAOException {
        this.connection = ConnectionFactory.getConnection();
    }
    
    /**
     * Recupera uma Regiao dado seu código
     * 
     * @param codigoRegiao
     * @return a Regiao
     * @throws SQLException 
     */
    public Regiao recuperarRegiao(Integer codigoRegiao) throws SQLException {
        
        Regiao r = new Regiao();
        String sql = "SELECT * FROM regiao WHERE co_regiao = ?";
        
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, codigoRegiao);
        
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            r.setCodigo(rs.getInt("co_regiao"));
            r.setNome(rs.getString("nome_regiao"));
        }
        
        return r;
        
    }
    
    
    /**
     * Recupera todas as Regioes do banco
     * 
     * @return uma List de Regiao
     * @throws SQLException 
     */
    public List<Regiao> recuperarRegioes() throws SQLException{
        
        List<Regiao> regioes = new ArrayList<>();
        
        String sql = "SELECT * FROM regiao";
        
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            Regiao r = new Regiao();
            r.setCodigo(rs.getInt("co_regiao"));
            r.setNome(rs.getString("nome_regiao"));
            
            regioes.add(r);
        }
        
        return regioes;
    }
    
    /**
     * Recupera uma Mesorregiao dado seu código
     * 
     * @param codigoMesorregiao
     * @return a Mesorregiao
     * @throws SQLException 
     */
    public Mesorregiao recuperarMesorregiao(Integer codigoMesorregiao) throws SQLException {
        
        Mesorregiao me = new Mesorregiao();
        String sql = "SELECT * FROM mesorregiao WHERE co_mesorregiao = ?";
        
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, codigoMesorregiao);
        
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            me.setCodigo(rs.getInt("co_mesorregiao"));
            me.setCodigoEstado(rs.getInt("co_uf"));
            me.setNome(rs.getString("nome_mesorregiao"));
        }
        
        return me;    
    
    }
    
    /**
     * Recupera uma Microrregiao dado seu código
     * 
     * @param codigoMicrorregiao
     * @return a Microrregiao
     * @throws SQLException 
     */
    public Microrregiao recuperarMicrorregiao(Integer codigoMicrorregiao) throws SQLException {
        
        Microrregiao mi = new Microrregiao();
        String sql = "SELECT * FROM microrregiao WHERE co_microrregiao = ?";
        
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, codigoMicrorregiao);
        
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            mi.setCodigo(rs.getInt("co_microrregiao"));
            mi.setCodigoMesorregiao(rs.getInt("co_mesorregiao"));
            mi.setNome(rs.getString("nome_microrregiao"));
        }
        
        return mi;
        
    }
    
    /**
     * Recupera um Distrito dado o seu código
     * 
     * @param codigoDistrito
     * @return o Distrito 
     * @throws SQLException 
     */
    public Distrito recuperarDistrito(Integer codigoDistrito) throws SQLException {
        
        Distrito d = new Distrito();
        String sql = "SELECT * FROM distrito WHERE co_distrito = ?";
        
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, codigoDistrito);
        
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            d.setCodigo(rs.getInt("co_distrito"));
            d.setCodigoMunicipio(rs.getInt("co_municipio"));
            d.setNome(rs.getString("nome_distrito"));
        }
        
        return d;        
    }
        
    
}
