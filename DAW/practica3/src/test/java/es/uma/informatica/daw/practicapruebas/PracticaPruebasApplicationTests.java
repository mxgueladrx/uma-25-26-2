package es.uma.informatica.daw.practicapruebas;

import es.uma.informatica.daw.practicapruebas.dtos.CitaDTO;
import es.uma.informatica.daw.practicapruebas.dtos.CitaNuevaDTO;
import es.uma.informatica.daw.practicapruebas.entidades.Cita;
import es.uma.informatica.daw.practicapruebas.entidades.EstadoCita;
import es.uma.informatica.daw.practicapruebas.repositorios.RepositorioCitas;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.resttestclient.TestRestTemplate;
import org.springframework.boot.resttestclient.autoconfigure.AutoConfigureTestRestTemplate;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.annotation.DirtiesContext;

import java.time.LocalDateTime;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
@AutoConfigureTestRestTemplate
@DisplayName("En el servicio de citas")
class PracticaPruebasApplicationTests {

    @Autowired
    private TestRestTemplate restTemplate;

    @LocalServerPort
    int port;

    @Autowired
    private RepositorioCitas repositorioCitas;

    private String url(String rutaYConsulta) {
        return "http://localhost:" + port + rutaYConsulta;
    }

    @Test
    @DisplayName("al buscar por fecha se encuentran las citas de ese día")
    void buscarPorFecha() {
        // Guarda una cita para el 30 de abril a las 10:00am de 1 hora
        Cita cita = new Cita();
        cita.setCliente("Juan");
        cita.setInicio(LocalDateTime.parse("2026-04-30T10:00:00"));
        cita.setDuracion(60);
        repositorioCitas.save(cita);

        // Consulta las citas del 30 de abril
        ResponseEntity<CitaDTO[]> res = restTemplate.getForEntity(
            url("/citas?fecha=2026-04-30"),
            CitaDTO[].class
        );

        // Comprueba que hay una
        assertThat(res.getBody()).hasSize(1);
    }

    // Crear cita

    @Test
    @DisplayName("crear una cita valida (201)")
    void crearCita201_1() {
        CitaNuevaDTO cita = new CitaNuevaDTO("Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60);

        var res = restTemplate.postForEntity(
                url("/citas"),
                cita,
                CitaDTO.class);

        assertThat(res.getStatusCode().value()).isEqualTo(201);
        assertThat(res.getHeaders().getLocation()).isNotNull();
        assertThat(res.getBody().getCliente()).isEqualTo("Miguel");
    }

    @Test
    @DisplayName("crear cita solapada con otra (409)")
    void crearCita409() {
        CitaNuevaDTO cita1 = new CitaNuevaDTO("Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60);
        CitaNuevaDTO cita2 = new CitaNuevaDTO("Otro", LocalDateTime.parse("2026-04-30T10:00:00"), 60);

        var res1 = restTemplate.postForEntity(url("/citas"), cita1, Object.class);
        var res2 = restTemplate.postForEntity(url("/citas"), cita2, Object.class);

        assertThat(res2.getStatusCode().value()).isEqualTo(409);
    }

    @Test
    @DisplayName("crear cita con duración inválida (400)")
    void crearCita400_1() {
        CitaNuevaDTO cita = new CitaNuevaDTO("Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 2);

        var res = restTemplate.postForEntity(
                url("/citas"),
                cita,
                CitaDTO.class);

        assertThat(res.getStatusCode().value()).isEqualTo(400);
    }

    @Test
    @DisplayName("crear cita con fecha de inicio inválida (400)")
    void crearCita400_2() {
        CitaNuevaDTO cita = new CitaNuevaDTO("Miguel", LocalDateTime.parse("2026-04-30T22:00:00"), 60);

        var res = restTemplate.postForEntity(
                url("/citas"),
                cita,
                CitaDTO.class);

        assertThat(res.getStatusCode().value()).isEqualTo(400);
    }

    @Test
    @DisplayName("crear cita en el mismo hueco de una cancelada (201)")
    void crearCita201_2() {
        Cita cancelada = new Cita(null, "Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60, EstadoCita.CANCELADA);
        repositorioCitas.save(cancelada);

        CitaNuevaDTO nueva = new CitaNuevaDTO("Otro", LocalDateTime.parse("2026-04-30T10:00:00"), 60);

        var res = restTemplate.postForEntity(
                url("/citas"),
                nueva,
                CitaDTO.class);

        assertThat(res.getStatusCode().value()).isEqualTo(201);
    }

    // Obtener cita

    @Test
    @DisplayName("obtener cita que existe (200)")
    void getCita200() {
        Cita cita = new Cita(null, "Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60, EstadoCita.CREADA);
        repositorioCitas.save(cita);

        var res = restTemplate.getForEntity(
                url("/citas/" + cita.getId()),
                CitaDTO.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(200);
        assertThat(res.getBody().getId()).isEqualTo(cita.getId());
    }

    @Test
    @DisplayName("obtener cita que no existe (404)")
    void getCita404() {
        var res = restTemplate.getForEntity(
                url("/citas/999"),
                CitaDTO.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(404);
    }

    // Confirmar cita

    @Test
    @DisplayName("confirmar cita que existe (200)")
    void confirmarCita200() {
        Cita cita = new Cita(null, "Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60, EstadoCita.CREADA);
        repositorioCitas.save(cita);

        var res = restTemplate.postForEntity(
                url("/citas/" + cita.getId() + "/confirmar"),
                null,
                CitaDTO.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(200);
        assertThat(res.getBody().getEstado()).isEqualTo(EstadoCita.CONFIRMADA);
    }

    @Test
    @DisplayName("confirmar cita que no existe (404)")
    void confirmarCita404() {
        var res = restTemplate.postForEntity(
                url("/citas/999/confirmar"),
                null,
                Object.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(404);
    }

    @Test
    @DisplayName("confirmar cita que existe pero no cumple regla de negocio (400)")
    void confirmarCita400() {
        Cita cita = new Cita(null, "Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60, EstadoCita.CANCELADA);
        repositorioCitas.save(cita);

        var res = restTemplate.postForEntity(
                url("/citas/" + cita.getId() + "/confirmar"),
                null,
                Object.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(400);
    }

    // Cancelar cita

    @Test
    @DisplayName("cancelar cita que existe (200)")
    void cancelarCita200() {
        Cita cita = new Cita(null, "Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60, EstadoCita.CONFIRMADA);
        repositorioCitas.save(cita);

        var res = restTemplate.postForEntity(
                url("/citas/" + cita.getId() + "/cancelar"),
                null,
                CitaDTO.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(200);
        assertThat(res.getBody().getEstado()).isEqualTo(EstadoCita.CANCELADA);
    }

    @Test
    @DisplayName("cancelar cita que no existe (404)")
    void cancelarCita404() {
        var res = restTemplate.postForEntity(
                url("/citas/999/cancelar"),
                null,
                Object.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(404);
    }

    @Test
    @DisplayName("cancelar cita que esta cancelada (400)")
    void cancelarCita400_1() {
        Cita cita = new Cita(null, "Miguel", LocalDateTime.parse("2026-04-30T10:00:00"), 60, EstadoCita.CANCELADA);
        repositorioCitas.save(cita);

        var res = restTemplate.postForEntity(
                url("/citas/" + cita.getId() + "/cancelar"),
                null,
                Object.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(400);
    }

    @Test
    @DisplayName("cancelar cita si falta menos de 24h (400)")
    void cancelarCita400_2() {
        Cita cita = new Cita(null, "Miguel", LocalDateTime.now().plusHours(2), 60, EstadoCita.CREADA);
        repositorioCitas.save(cita);

        var res = restTemplate.postForEntity(
                url("/citas/" + cita.getId() + "/cancelar"),
                null,
                Object.class
        );

        assertThat(res.getStatusCode().value()).isEqualTo(400);
    }
}
