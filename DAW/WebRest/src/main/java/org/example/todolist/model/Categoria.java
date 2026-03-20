package org.example.todolist.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "categorias")
public class Categoria { // Categoria 1 -- n Tarea
    @Id @GeneratedValue
    private Long id;
    private String titulo;
    @OneToMany(mappedBy = "categoria")
    private List<Tarea> tareas = new ArrayList<>();

    public Categoria() {

    }
}
