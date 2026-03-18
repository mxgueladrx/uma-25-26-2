package org.example.todolist.service;

import org.example.todolist.dto.TareaDTO;
import org.example.todolist.model.Tarea;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TareaService {
    private List<Tarea> listaTareas = new ArrayList<>();
    private Long idCounter = 1L;

    public List<TareaDTO> listarTodo() {
        return listaTareas.stream()
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .toList();
    }

    public Optional<TareaDTO> obtenerPorId(Long id) {
        return listaTareas.stream()
                .filter(t -> t.getId().equals(id))
                .findFirst()
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()));
    }

    public List<TareaDTO> filtrar(String titulo) {
        return listaTareas.stream()
                .filter(t -> t.getTitulo().toLowerCase().contains(titulo.toLowerCase()))
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .toList();
    }

    public Optional<TareaDTO> crear(String titulo) { // Cualquier POST devuelve siempre el objeto creado
        if (titulo == null || titulo.isEmpty()) {
            return Optional.empty();
        }

        Tarea tarea = new Tarea(idCounter++, titulo, false, "ALTA");
        listaTareas.add(tarea);
        return Optional.of(new TareaDTO(tarea.getId(), tarea.getTitulo(), tarea.isCompletada())); // Devolvemos el DTO envuelto en un Optional
    }

    public Optional<TareaDTO> completar(Long id) {
        return listaTareas.stream()
                .filter(t -> t.getId().equals(id))
                .findFirst() // Devuelve Optional<Tarea>
                .map(t -> { // Si existe la tarea, entra aquí
                    t.setCompletada(true);
                    return new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada());
                }); // Si no existe, el Optional se mantiene vacío automáticamente
    }

    public void eliminar(Long id) { // Cuando se elimina algo se manda un código de estado 2xx, 3xx, 4xx
        listaTareas.removeIf(t -> t.getId().equals(id));
    }
}
