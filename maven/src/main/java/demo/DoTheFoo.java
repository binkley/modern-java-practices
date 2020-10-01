package demo;

import lombok.Getter;

public class DoTheFoo implements Foo {
    public static final String THE_FOO = "I am the Foo!";

    // TODO: Demonstrate testing STDOUT
    @Getter
    private String out;

    @Override
    public void doIt() {
        out = THE_FOO;
    }
}
