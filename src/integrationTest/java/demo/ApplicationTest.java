package demo;

import org.junit.jupiter.api.Test;

import static demo.TerminalContext.captureTerminal;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Just an example of Unit test.
 */
@SuppressWarnings({
        "PMD.AtLeastOneConstructor",
        "PMD.SignatureDeclareThrowsException"
})
class ApplicationTest {

    /**
     * <strong>Use case</strong>: the application runs normally.
     **/
    @Test
    void shouldRun() {
        final var out = captureTerminal(() -> Application.main("pwd"));

        assertThat(out).isEqualTo("TheFoo(label=I AM FOOCUTUS OF BORG)\n");
    }
}
