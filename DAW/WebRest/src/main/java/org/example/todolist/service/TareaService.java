package org.example.todolist.service;

import org.example.todolist.dto.TareaDTO;
import org.example.todolist.model.Tarea;
import org.example.todolist.repository.TareaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TareaService {
    @Autowired
    private TareaRepository tareaRepository;

    public List<TareaDTO> listarTodo() {
        return tareaRepository.findAll()
                .stream()
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .toList();
    }

    public Optional<TareaDTO> obtenerPorId(Long id) {
        return tareaRepository.findById(id)
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()));
    }

    public List<TareaDTO> filtrar(String titulo) {
        return tareaRepository.findByTituloContainingIgnoreCase(titulo)
                .stream()
                .map(t -> new TareaDTO(t.getId(), t.getTitulo(), t.isCompletada()))
                .toList();
    }

    public Optional<TareaDTO> crear(String titulo) { // Cualquier POST devuelve siempre el objeto creado
        if (titulo == null || titulo.isEmpty()) {
            return Optional.empty();
        }

        Tarea tarea = new Tarea();
        tarea.setTitulo(titulo);
        tarea.setCompletada(false);
        tarea.setPrioridad("ALTA");

        return Optional.of(DtoAndEntityMapper.toDto(tareaRepository.save(tarea))); // Devolvemos el DTO envuelto en un Optional
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
        tareaRepository.deleteById(id);
    }
}
