package org.example.helloworld.service;

import org.example.helloworld.dto.MensajeDTO;
import org.example.helloworld.model.Mensaje;
import org.springframework.stereotype.Service;

@Service
public class MensajeService {
    public MensajeDTO generarSaludo(String nombre, int edad) {
        Mensaje mensaje = new Mensaje(nombre, edad);

    }
}
