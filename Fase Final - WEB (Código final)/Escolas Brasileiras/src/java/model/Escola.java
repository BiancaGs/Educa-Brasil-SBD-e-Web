
package model;

import java.time.LocalDate;

/**
 * @author Pietro
 * @author Bianca
 */
public class Escola {
    
    // =================================
    // Referência aos outros Beans
    // =================================

    private EscolaOfertas eo;
    private EscolaDependenciasGerais edg;
    private EscolaDependenciasFisicas edf;

    
    // =================================
    // Atributos
    // =================================
    
    private Integer codigo;
    private String nome;
    private String situacaoFuncionamento;      // Em atividade / Extinta / Paralisada
    private String inicioAnoLetivo;
    private String terminoAnoLetivo;
    private Integer codigoDistrito;
    private String localizacao;                // Rural / Urbana
    private String dependenciaAdm;             // Federal / Estadual / Municipal / Privada
    private Boolean regulamentada;
    private Integer qtdSalasExistentes;
    private Integer qtdSalasUtilizadas;
    private Integer qtdFuncionarios;

    
    // =================================
    // Get e Set
    // =================================
    
    public EscolaOfertas getEo() {
        return eo;
    }

    public void setEo(EscolaOfertas eo) {
        this.eo = eo;
    }

    public EscolaDependenciasGerais getEdg() {
        return edg;
    }

    public void setEdg(EscolaDependenciasGerais edg) {
        this.edg = edg;
    }

    public EscolaDependenciasFisicas getEdf() {
        return edf;
    }

    public void setEdf(EscolaDependenciasFisicas edf) {
        this.edf = edf;
    }

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

    public String getSituacaoFuncionamento() {
        return situacaoFuncionamento;
    }

    public void setSituacaoFuncionamento(String situacaoFuncionamento) {
        this.situacaoFuncionamento = situacaoFuncionamento;
    }

    public String getInicioAnoLetivo() {
        return inicioAnoLetivo;
    }

    public void setInicioAnoLetivo(String inicioAnoLetivo) {
        this.inicioAnoLetivo = inicioAnoLetivo;
    }

    public String getTerminoAnoLetivo() {
        return terminoAnoLetivo;
    }

    public void setTerminoAnoLetivo(String terminoAnoLetivo) {
        this.terminoAnoLetivo = terminoAnoLetivo;
    }

    public Integer getCodigoDistrito() {
        return codigoDistrito;
    }

    public void setCodigoDistrito(Integer codigoDistrito) {
        this.codigoDistrito = codigoDistrito;
    }

    public String getLocalizacao() {
        return localizacao;
    }

    public void setLocalizacao(String localizacao) {
        this.localizacao = localizacao;
    }

    public String getDependenciaAdm() {
        return dependenciaAdm;
    }

    public void setDependenciaAdm(String dependenciaAdm) {
        this.dependenciaAdm = dependenciaAdm;
    }

    public Boolean getRegulamentada() {
        return regulamentada;
    }

    public void setRegulamentada(Boolean regulamentada) {
        this.regulamentada = regulamentada;
    }

    public Integer getQtdSalasExistentes() {
        return qtdSalasExistentes;
    }

    public void setQtdSalasExistentes(Integer qtdSalasExistentes) {
        this.qtdSalasExistentes = qtdSalasExistentes;
    }

    public Integer getQtdSalasUtilizadas() {
        return qtdSalasUtilizadas;
    }

    public void setQtdSalasUtilizadas(Integer qtdSalasUtilizadas) {
        this.qtdSalasUtilizadas = qtdSalasUtilizadas;
    }

    public Integer getQtdFuncionarios() {
        return qtdFuncionarios;
    }

    public void setQtdFuncionarios(Integer qtdFuncionarios) {
        this.qtdFuncionarios = qtdFuncionarios;
    }
    
  
}