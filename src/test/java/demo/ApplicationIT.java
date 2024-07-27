package demo;

import org.junit.jupiter.api.Test;

import static com.github.stefanbirkner.systemlambda.SystemLambda.tapSystemOutNormalized;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Integration test for the application.
 */
@SuppressWarnings("PMD.AtLeastOneConstructor")
class ApplicationIT {
    /** <strong>Use case</strong>: the application runs normally. */
    @Test
    void shouldRun() throws Exception {
        final var out = tapSystemOutNormalized(Application::main);

        assertThat(out).isEqualTo("TheFoo(label=I AM FOOCUTUS OF BORG)\n");
    }
}
