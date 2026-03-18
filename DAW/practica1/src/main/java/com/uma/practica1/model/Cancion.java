package com.uma.practica1.model;

public class Cancion {
    private Long id;
    private String titulo;
    private String cantante;
    private Integer anio;

    public Cancion(Long id, String titulo, String cantante, Integer anio) {
        this.id = id;
        this.titulo = titulo;
        this.cantante = cantante;
        this.anio = anio;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
