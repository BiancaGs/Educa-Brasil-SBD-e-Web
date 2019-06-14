package lib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * @author Pietro
 * @author Bianca
 *
 * Classe de teste para a conexão com o Banco de Dados
 */
public class DBTest {

    private Connection conn;
    private Statement stmt;

    public DBTest() {
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            String connection = "jdbc:postgresql://localhost/escolas_brasileiras";
            String user = "postgres", password = "1234";
            conn = DriverManager.getConnection(connection, user, password);
            stmt = conn.createStatement();

            System.out.println("Conexão com Sucesso!");

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error: something went wrong...");
        }
    }

    public static void main(String args[]) {
        DBTest t = new DBTest();
    }
}
