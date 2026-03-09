package org.example.todolist.controller;

import org.example.todolist.dto.TareaDTO;
import org.example.todolist.service.TareaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tareas")
public class TareaController {
    @Autowired
    private TareaService tareaService;

    @GetMapping
    public List<TareaDTO> listarTodo() {
        return tareaService.listarTodo();
    }

    @PostMapping
    public TareaDTO crear(@RequestBody TareaDTO tarea) {
        return tareaService.crear(tarea.getTitulo());
    }
}
