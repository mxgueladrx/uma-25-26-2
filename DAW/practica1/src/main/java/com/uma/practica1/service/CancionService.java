package com.uma.practica1.service;

import com.uma.practica1.dto.CancionDTO;
import com.uma.practica1.model.Cancion;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CancionService {
    private List<Cancion> canciones = new ArrayList<>();
    private Long idCounter = 1L;

    public List<Cancion> obtenerTodas() {
        return canciones;
    }

    public Optional<Cancion> aniadir(String titulo, String cantante, Integer anio) {
        if (titulo.isEmpty() || cantante.isEmpty() || anio == null) {
            return Optional.empty();
        }

        Cancion cancion = new Cancion(idCounter++, titulo, cantante, anio);
        canciones.add(cancion);
        return Optional.of(cancion);
    }

    public Optional<Cancion> obtenerPorId(Long id) {
        return canciones.stream()
                .filter(c -> c.getId().equals(id))
                .findFirst();
    }

    public Optional<Cancion> actualizar(Long id, String titulo, String cantante, Integer anio) {
        if (titulo.isEmpty() || cantante.isEmpty() || anio == null) {
            return Optional.empty();
        }

        return canciones.stream()
                .filter(c -> c.getId().equals(id))
                .findFirst()
                .map(c -> {
                    c.setTitulo(titulo);
                    c.setCantante(cantante);
                    c.setAnio(anio);

                    return c;
                });
    }

    public void eliminar(Long id) {
        canciones.removeIf(c -> c.getId().equals(id));
    }

    public List<Cancion> obtenerPorCantante(String cantante) {
        return canciones.stream()
                .filter(c -> c.getCantante().toLowerCase().contains(cantante.toLowerCase()))
                .toList();
    }
}
