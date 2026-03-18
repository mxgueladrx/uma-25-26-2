package com.uma.practica1.controller;

import com.uma.practica1.dto.CancionDTO;
import com.uma.practica1.model.Cancion;
import com.uma.practica1.service.CancionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/canciones")
public class CancionController {
    @Autowired
    private CancionService cancionService;

    @GetMapping
    public ResponseEntity<List<Cancion>> obtenerTodas(@RequestParam(name = "cantante", required = false) String cantante) {
        if (cantante != null) {
            return ResponseEntity.ok(cancionService.obtenerPorCantante(cantante));
        }
        return ResponseEntity.ok(cancionService.obtenerTodas());
    }

    @PostMapping
    public ResponseEntity<Cancion> aniadir(@RequestBody CancionDTO cancion, UriComponentsBuilder uriComponentsBuilder) {
        Optional<Cancion> c = cancionService.aniadir(cancion.getTitulo(), cancion.getCantante(), cancion.getAnio());
        URI location = uriComponentsBuilder.path("/canciones/{id}")
                .buildAndExpand(c.get().getId())
                .toUri();

        return ResponseEntity.created(location).body(c.get());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Cancion> obtenerPorId(@PathVariable(name = "id") Long id) {
        return cancionService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Cancion> actualizar(@PathVariable(name = "id") Long id, @RequestBody CancionDTO cancion) {
        return cancionService.actualizar(id,cancion.getTitulo(), cancion.getCantante(), cancion.getAnio())
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable(name = "id") Long id) {
        if (cancionService.obtenerPorId(id).isPresent()) {
            cancionService.eliminar(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
