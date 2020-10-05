package demo;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class DoTheFooTest {
    @Test
    void shouldKnowTheFoo() {
        final var theFoo = "I am the Foo!";
        final var didTheFoo = new DoTheFoo(theFoo);

        assertThat(didTheFoo.getFoo()).isEqualTo(theFoo);
    }
}
