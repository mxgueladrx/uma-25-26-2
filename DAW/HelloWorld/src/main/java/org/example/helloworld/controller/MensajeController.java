package org.example.helloworld.controller;

import org.example.helloworld.dto.MensajeDTO;
import org.example.helloworld.service.MensajeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class MensajeController {

    @Autowired
    private MensajeService mensajeService;

    @GetMapping("/saludo")
    public MensajeDTO saludar(@RequestParam())
}
