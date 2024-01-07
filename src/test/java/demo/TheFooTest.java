package demo;

import edu.umd.cs.findbugs.annotations.SuppressFBWarnings;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

import static demo.TheFoo.checkRedAlert;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

/**
 * An example of test class.
 */
@SuppressFBWarnings({
        "NP_NONNULL_PARAM_VIOLATION",
        "NP_NULL_PARAM_DEREF_NONVIRTUAL"
})
@SuppressWarnings({
        "PMD.TooManyStaticImports",
        "PMD.AtLeastOneConstructor"
})
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

    @SuppressFBWarnings("RCN_REDUNDANT_NULLCHECK_WOULD_HAVE_BEEN_A_NPE")
    @Test
    void shouldRedAlertAsStaticMock() {
        final var label = "Some label, *mumble, mumble*. <IRRELEVANT>";

        try (MockedStatic<TheFoo> mockFoo = mockStatic(TheFoo.class)) {
            mockFoo.when(() -> checkRedAlert(eq(label))).thenReturn(true);

            assertThat(new TheFoo(label).isRedAlert())
                    .isTrue();
        }
    }
}
