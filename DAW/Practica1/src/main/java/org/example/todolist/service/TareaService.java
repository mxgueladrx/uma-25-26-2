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

    public List<TareaDTO> listarTodo() {
        return listaTareas.stream()
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .toList();
    }

    public TareaDTO obtenerPorId(Long id) {
        return listaTareas.stream()
                .filter(t -> t.getId().equals(id))
                .findFirst()
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .orElseThrow(() -> new RuntimeException("Id no encontrado")); // O devolver null
    }

    public List<TareaDTO> filtrar(String titulo) {
        return listaTareas.stream()
                .filter(t -> t.getTitulo().toLowerCase().contains(titulo.toLowerCase()))
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .toList();
    }

    public TareaDTO crear(String titulo) { // Cualquier POST devuelve siempre el objeto creado
        Tarea tarea = new Tarea(idCounter++, titulo, false, "ALTA");
        listaTareas.add(tarea);
        return new TareaDTO(tarea.getId(), tarea.getTitulo(), tarea.isCompletada());
    }

    public TareaDTO completar(Long id) {
        return listaTareas.stream()
                .filter(t -> t.getId().equals(id))
                .findFirst()
                .map(t -> {
                    t.setCompletada(true);
                    return new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada());
                })
                .orElseThrow(() -> new RuntimeException("Id no encontrado")); // O devolver null
    }

    public void eliminar(Long id) { // Cuando se elimina algo se manda un código de estado 2xx, 3xx, 4xx
        listaTareas.removeIf(t -> t.getId().equals(id));
    }
}
