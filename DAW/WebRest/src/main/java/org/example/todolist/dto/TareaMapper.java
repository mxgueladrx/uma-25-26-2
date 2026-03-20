package org.example.todolist.dto;

import org.example.todolist.model.Tarea;

public class TareaMapper {
    public TareaDTO toDto(Tarea tarea) {
        return new TareaDTO(tarea.getId(), tarea.getTitulo(), tarea.isCompletada());
    }

    public Tarea toEntity(TareaDTO tareaDto) {
        return new Tarea()
    }
}
