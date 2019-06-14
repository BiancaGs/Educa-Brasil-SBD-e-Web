
package model;

/**
 *
 * @author Pietro
 * @author Bianca
 */
public class Estado {
    
    
    private Integer codigo;
    private String nome;
    private String sigla;
    private Integer codigoRegiao;

    
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

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public Integer getCodigoRegiao() {
        return codigoRegiao;
    }

    public void setCodigoRegiao(Integer codigoRegiao) {
        this.codigoRegiao = codigoRegiao;
    }
    
}
