package org.example.helloworld.model;

public class Mensaje {
    private String nombre;
    private int edad;
    private String ip;

    public String getIp() {
        return ip;
    }

    public int getEdad() {
        return edad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
