package demo;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class TheFooTest {
    @Test
    void shouldKnowTheFoo() {
        final var theFoo = "I am the Foo!";
        final var didTheFoo = new TheFoo(theFoo);

        assertThat(didTheFoo.getLabel()).isEqualTo(theFoo);
    }

    @SuppressWarnings("ConstantConditions")
    @Test
    void shouldComplainWhenInvalid() {
        assertThatThrownBy(() -> new TheFoo(null))
                .isInstanceOf(NullPointerException.class);
    }

    @Test
    void shouldRedAlert() {
        assertThat(new TheFoo("We are the Borg.").isRedAlert())
                .isTrue();
    }

    @Test
    void shouldNotRedAlert() {
        assertThat(new TheFoo("My debt is repaid.").isRedAlert())
                .isFalse();
    }
}
