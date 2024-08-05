package demo;

import org.junit.jupiter.api.Test;

import static demo.TerminalContext.captureTerminal;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Integration test for the application.
 */
@SuppressWarnings({
        // PMD does not understand FooIT.java as a test class
        "PMD.AtLeastOneConstructor",
})
class ApplicationIT {
    /**
     * <strong>Use case</strong>: the application runs normally.
     */
    @Test
    void shouldRun() {
        final var out = captureTerminal(Application::main);

        assertThat(out).isEqualTo("TheFoo(label=I AM FOOCUTUS OF BORG)\n");
    }
}
