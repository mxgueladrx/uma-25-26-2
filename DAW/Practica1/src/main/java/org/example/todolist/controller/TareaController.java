package org.example.todolist.controller;

import org.example.todolist.dto.TareaDTO;
import org.example.todolist.service.TareaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tareas")
public class TareaController {
    @Autowired
    private TareaService tareaService;

    // Ejemplo de llamada -> GET http://localhost:8080/api/tareas/
    @GetMapping
    public ResponseEntity<List<TareaDTO>> listarTodo() {
        List<TareaDTO> tareas = tareaService.listarTodo();
        // Usamos .ok() para devolver un 200 OK.
        // En listados, aunque esté vacía, la petición ha tenido éxito.
        return ResponseEntity.ok(tareas);
    }

    // Ejemplo de llamada -> GET http://localhost:8080/api/tareas/1
    @GetMapping("/{id}")
    public ResponseEntity<TareaDTO> obtenerPorId(@PathVariable(name = "id") Long id) {
        // .map() transforma el Optional en un 200 OK si existe.
        // .orElse() devuelve un 404 Not Found si el ID no está en el sistema.
        return tareaService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Ejemplo de llamada -> GET http://localhost:8080/api/tareas/buscar?titulo=hola
    @GetMapping("/buscar")
    public ResponseEntity<List<TareaDTO>> filtrar(@RequestParam(name = "titulo", required = false, defaultValue = "") String titulo) {
        // 200 OK: El cliente pidió filtrar y le devolvemos el resultado (sea cual sea).
        return ResponseEntity.ok(tareaService.filtrar(titulo));
    }

    // Ejemplo de llamada -> POST http://localhost:8080/api/tareas pasando JSON de DTO n body
    @PostMapping
    public ResponseEntity<TareaDTO> crear(@RequestBody TareaDTO tarea) {
        return tareaService.crear(tarea.getTitulo())
                .map(t -> ResponseEntity.status(HttpStatus.CREATED).body(t)) // 201 Created: Estándar REST para creación.
                .orElse(ResponseEntity.badRequest().build()); // 400 Bad Request: Si el título era null o vacío.
    }

    // Ejemplo de llamada -> PUT http://localhost:8080/api/tareas/1
    @PutMapping("/{id}")
    public ResponseEntity<TareaDTO> completar(@PathVariable(name = "id") Long id) {
        // Si el servicio logra completar la tarea (existe), devuelve 200 OK con los datos actualizados.
        // Si el ID no existe, devuelve 404 Not Found.
        return tareaService.completar(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Ejemplo de llamada -> DELETE http://localhost:8080/api/tareas/1
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable(name = "id") Long id) {
        tareaService.eliminar(id);
        // 204 No Content: La acción se realizó con éxito pero no hay nada que devolver en el cuerpo.
        return ResponseEntity.noContent().build();
    }
}
