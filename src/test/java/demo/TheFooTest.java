package demo;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class TheFooTest {
    @Test
    void shouldKnowTheFoo() {
        final var theFoo = "I am the Foo!";
        final var didTheFoo = new TheFoo(theFoo);

        assertThat(didTheFoo.getLabel()).isEqualTo(theFoo);
    }

    @Test
    void shouldBeFull() {
        final var aFoo = new TheFoo("Bob the Builder");

        assertThat(aFoo.isEmpty()).isFalse();
    }

    @Test
    void shouldBeEmpty() {
        final var aFoo = new TheFoo(null);

        assertThat(aFoo.isEmpty()).isTrue();
    }
}
