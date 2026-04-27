package es.uma.informatica.daw.practicapruebas.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@NoArgsConstructor // para poder hacer tests
@AllArgsConstructor // para poder hacer tests
public class Cita {
    @Id
    @GeneratedValue
    private Long id;
    private String cliente;
    private LocalDateTime inicio;
    private Integer duracion; //duración en minutos
    private EstadoCita estado;

    public LocalDateTime getFin() {
        return inicio.plusMinutes(duracion);
    }
}