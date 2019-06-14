
package model;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class Municipio {
    
    private Integer codigo;
    private String nome;
    private Integer codigoMicrorregiao;
    private Float latitude;
    private Float longitude;
    
    // ======================================
    // Get e Set
    // ======================================

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Integer getCodigoMicrorregiao() {
        return codigoMicrorregiao;
    }

    public void setCodigoMicrorregiao(Integer codigoMicrorregiao) {
        this.codigoMicrorregiao = codigoMicrorregiao;
    }

    public Float getLatitude() {
        return latitude;
    }

    public void setLatitude(Float latitude) {
        this.latitude = latitude;
    }

    public Float getLongitude() {
        return longitude;
    }

    public void setLongitude(Float longitude) {
        this.longitude = longitude;
    }
    
}
