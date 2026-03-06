package org.example;
import javax.json.bind.Jsonb;
import javax.json.bind.JsonbBuilder;

/**
 * Hello world!
 *
 */
public class App {
    public static void main( String[] args ) {
        // Create a dog instance
        Dog dog = new Dog();
        dog.name = "Falco";
        dog.age = 4;
        dog.bitable = false;

        // Create Jsonb and serialize
        Jsonb jsonb = JsonbBuilder.create();
        String result = jsonb.toJson(dog);
        System.out.println(result);

        dog = jsonb.fromJson("{\"age\":4,\"bitable\":false,\"name\":\"Falco\"}", Dog.class);
    }
}
