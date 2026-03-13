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

    @GetMapping("/{id}")
    public TareaDTO obtenerPorId(@PathVariable(name = "id") Long id) {
        return tareaService.obtenerPorId(id);
    }

    @GetMapping("/buscar")
    public List<TareaDTO> filtrar(@RequestParam(name = "titulo", required = false, defaultValue = "") String titulo) {
        return tareaService.filtrar(titulo);
    }

    @PostMapping
    public TareaDTO crear(@RequestBody TareaDTO tarea) {
        return tareaService.crear(tarea.getTitulo());
    }

    @PutMapping("/{id}")
    public TareaDTO completar(@PathVariable(name = "id") Long id) {
        return tareaService.completar(id);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable(name = "id") Long id) {
        tareaService.eliminar(id);
    }
}
