package es.uma.informatica.daw.practicapruebas.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor // para poder hacer tests
@AllArgsConstructor // para poder hacer tests
public class CitaNuevaDTO {
    private String cliente;
    private LocalDateTime inicio;
    private Integer duracion; //duración en minutos
}
