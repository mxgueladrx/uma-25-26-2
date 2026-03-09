package org.example.helloworld.service;

import org.example.helloworld.dto.MensajeDTO;
import org.example.helloworld.model.Mensaje;
import org.springframework.stereotype.Service;

@Service
public class MensajeService {
    public MensajeDTO generarSaludo(String nombre, String ipCliente) {
        // 1. Creamos el objeto de negocio con todos los datos (IP incluida)
        Mensaje mensajeInterno = new Mensaje("¡Hola " + nombre + "!", "Sistema Central", ipCliente);

        // Simulación: aquí podríamos guardar 'mensajeInterno' en la DB (Sistema de Información)
        System.out.println("Log: Guardando mensaje desde la IP: " + mensajeInterno.getIpOrigen());

        // 2. Mapeamos manualmente al DTO para "limpiar" la respuesta
        return new MensajeDTO(mensajeInterno.getContenido(), mensajeInterno.getEmisor());
    }
}