package org.example.todolist.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tareas")
public class Tarea { // Tarea n -- 1 Categoría
    @Id @GeneratedValue()
    private Long id;
    private String titulo;
    private boolean completada;
    private String prioridad;
    @ManyToOne @JoinColumn(name = "categoria_id") // Join column en la tabla del "n"
    private Categoria categoria;

    public Tarea() {

    }

    public Tarea(Long id, String titulo, boolean completada, String prioridad) {
        this.id = id;
        this.titulo = titulo;
        this.completada = completada;
        this.prioridad = prioridad;
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

    public boolean isCompletada() {
        return completada;
    }

    public void setCompletada(boolean completada) {
        this.completada = completada;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }
}
