package org.example.todolist.service;

import org.example.todolist.dto.TareaDTO;
import org.example.todolist.model.Tarea;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TareaService {
    private List<Tarea> listaTareas = new ArrayList<>();
    private Long idCounter = 1L;

    public TareaDTO crear(String titulo) { // Cualquier POST devuelve siempre el objeto creado
        Tarea tarea = new Tarea(idCounter++, titulo, false, "ALTA");
        listaTareas.add(tarea);
        return new TareaDTO(tarea.getId(), tarea.getTitulo(), tarea.isCompletada());
    }

    public List<TareaDTO> listarTodo() {
        return listaTareas.stream()
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .toList();
    }
}
