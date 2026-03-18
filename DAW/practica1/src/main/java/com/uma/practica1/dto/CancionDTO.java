package com.uma.practica1.dto;

public class CancionDTO {
    private String titulo;
    private String cantante;
    private Integer anio;

    public CancionDTO(String titulo, String cantante, Integer anio) {
        this.titulo = titulo;
        this.cantante = cantante;
        this.anio = anio;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getCantante() {
        return cantante;
    }

    public void setCantante(String cantante) {
        this.cantante = cantante;
    }

    public Integer getAnio() {
        return anio;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
    }
}
