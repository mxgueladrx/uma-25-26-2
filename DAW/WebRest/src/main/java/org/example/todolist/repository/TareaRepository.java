package org.example.todolist.repository;

import org.example.todolist.model.Tarea;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TareaRepository extends JpaRepository<Tarea, Long> { // Clase de la entidad y el tipo de la clave primaria
    public List<Tarea> findByTituloContainingIgnoreCase(String titulo);
}
