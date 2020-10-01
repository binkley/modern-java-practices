package demo;

import org.junit.jupiter.api.Test;

import static demo.DoTheFoo.THE_FOO;
import static org.junit.jupiter.api.Assertions.assertEquals;

class DoTheFooTest {
    @Test
    void shouldKnowTheFoo() {
        final var theFoo = new DoTheFoo();

        theFoo.doIt();

        assertEquals(THE_FOO, theFoo.getOut());
    }
}
