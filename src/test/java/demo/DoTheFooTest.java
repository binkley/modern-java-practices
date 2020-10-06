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

    @Test
    void shouldBeFull() {
        final var aFoo = new DoTheFoo("Bob the Builder");

        assertThat(aFoo.isEmpty()).isFalse();
    }

    @Test
    void shouldBeEmpty() {
        final var aFoo = new DoTheFoo(null);

        assertThat(aFoo.isEmpty()).isTrue();
    }
}
