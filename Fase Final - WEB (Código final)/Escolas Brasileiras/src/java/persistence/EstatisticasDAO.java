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
import model.Municipio;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class EstatisticasDAO {
    
    private Connection connection;

    public EstatisticasDAO() throws DAOException {
        this.connection = ConnectionFactory.getConnection();
    }
    
    public String recuperarEstatisticas(String brasil, String codigoRegiao, String codigoEstado, String codigoMunicipio) throws DAOException, SQLException {
        
        String sql = "";

        if ( !brasil.equals("sim") ) {
            
            if ( !codigoRegiao.isEmpty()  ) {
                // SQL da Regiao
                sql = "SELECT * FROM recuperarEstatisticas(NULL, '"+codigoRegiao+"', NULL, NULL)";
            }
            else if ( !codigoEstado.isEmpty() ) {
                // SQL do Estado
                sql = "SELECT * FROM recuperarEstatisticas(NULL, NULL, '"+codigoEstado+"', NULL)";
            }
            else if ( !codigoMunicipio.isEmpty() ) {
                // SQL do Municipio
                sql = "SELECT * FROM recuperarEstatisticas(NULL, NULL, NULL, '"+codigoMunicipio+"')";
            }
            
        }
        else {

            // SQL do Brasil
            sql = "SELECT * FROM recuperarEstatisticas(true, NULL, NULL, NULL)";

        }
        
        
        PreparedStatement stmt = ConnectionFactory.getConnection().prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        Integer nEscolas = 0;

        // Dependência
        Integer nFederal = 0;
        Integer nEstadual = 0;
        Integer nMunicipal = 0;
        Integer nPrivada = 0;

        // Situação
        Integer nAtividade = 0;
        Integer nParalisada = 0;
        Integer nExtinta = 0;

        // Localização
        Integer nRural = 0;
        Integer nUrbana = 0;

        // Ofertas
        Integer nB = 0;
        Integer nC = 0;
        Integer nPE = 0;
        Integer nEFI = 0;
        Integer nEFII = 0;
        Integer nEMN = 0;
        Integer nEMI = 0;


        while (rs.next()) {                    

            // Dependência
            if (rs.getInt("g_dep") == 0) {
                switch (rs.getString("dependencia_adm")) {
                    case "Federal":
                        nFederal = rs.getInt("qtd_escolas");
                        break;
                    case "Estadual":
                        nEstadual = rs.getInt("qtd_escolas");
                        break;
                    case "Municipal":
                        nMunicipal = rs.getInt("qtd_escolas");
                        break;
                    case "Privada":
                        nPrivada = rs.getInt("qtd_escolas");
                        break;
                }
                continue;
            }

            // Situação
            if (rs.getInt("g_situacao") == 0) {
                switch (rs.getString("situacao_funcionamento")) {
                    case "Em atividade":
                        nAtividade = rs.getInt("qtd_escolas");
                        break;
                    case "Paralisada":
                        nParalisada = rs.getInt("qtd_escolas");
                        break;
                    case "Extinta":
                        nExtinta = rs.getInt("qtd_escolas");
                        break;
                }
                continue;
            }

            // Localização
            if (rs.getInt("g_localizacao") == 0) {
                switch (rs.getString("localizacao")) {
                    case "Urbana":
                        nUrbana = rs.getInt("qtd_escolas");
                        break;
                    case "Rural":
                        nRural = rs.getInt("qtd_escolas");
                        break;
                }
                continue;
            }

            // Ofertas
            if (rs.getBoolean("bercario") == true) {
                nB = rs.getInt("qtd_escolas");
            }
            if (rs.getBoolean("creche") == true) {
                nC = rs.getInt("qtd_escolas");
            }
            if (rs.getBoolean("pre_escola") == true) {
                nPE = rs.getInt("qtd_escolas");
            }
            if (rs.getBoolean("ens_fundamental_anos_iniciais") == true) {
                nEFI = rs.getInt("qtd_escolas");
            }
            if (rs.getBoolean("ens_fundamental_anos_finais") == true) {
                nEFII = rs.getInt("qtd_escolas");
            }
            if (rs.getBoolean("ens_medio_normal") == true) {
                nEMN = rs.getInt("qtd_escolas");
            }
            if (rs.getBoolean("ens_medio_integrado") == true) {
                nEMI = rs.getInt("qtd_escolas");
            }


        }

        nEscolas = nRural + nUrbana;


        // =======================================
        // Cria o JSON
        // =======================================

        String json = "";

        json += "{";
        json += "\"Total\":" + nEscolas.toString() + ",";
        
        // Recupera as informações do Município (LAT e LONG), caso aplicável
        if ( !codigoMunicipio.isEmpty() ) {
            MunicipioDAO mdao = new MunicipioDAO();
            Municipio m = mdao.buscar(codigoMunicipio);
            json += "\"Latitude\":" + m.getLatitude() + ",";
            json += "\"Longitude\":" + m.getLongitude() + ",";
        }
        
        json += "\"Federal\":" + nFederal.toString() + ",";
        json += "\"Estadual\":" + nEstadual.toString() + ",";
        json += "\"Municipal\":" + nMunicipal.toString() + ",";
        json += "\"Privada\":" + nPrivada.toString() + ",";
        json += "\"Atividade\":" + nAtividade.toString() + ",";
        json += "\"Paralisada\":" + nParalisada.toString() + ",";
        json += "\"Extinta\":" + nExtinta.toString() + ",";
        json += "\"Urbana\":" + nUrbana.toString() + ",";
        json += "\"Rural\":" + nRural.toString() + ",";
        json += "\"B\":" + nB.toString() + ",";
        json += "\"C\":" + nC.toString() + ",";
        json += "\"PE\":" + nPE.toString() + ",";
        json += "\"EFI\":" + nEFI.toString() + ",";
        json += "\"EFII\":" + nEFII.toString() + ",";
        json += "\"EMN\":" + nEMN.toString() + ",";
        json += "\"EMI\":" + nEMI.toString() + "";
        json += "}";


        return json;
        
    }
    
}
