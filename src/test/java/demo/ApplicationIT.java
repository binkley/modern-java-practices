package demo;

import org.junit.jupiter.api.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static java.nio.charset.StandardCharsets.UTF_8;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Integration test for the application.
 */
@SuppressWarnings({
        "PMD.AtLeastOneConstructor",
        "PMD.CommentSize" // Complain to PMD, and suppress in config
})
class ApplicationIT {
    /**
     * <strong>Use case</strong>: the application runs normally.
     */
    @Test
    void shouldRun() {
        try (var context = captureTerminal()) {
            // We could write ContextForTerminal for lambdas, but:
            // 1. More explicit/natural calls for capture of the console.
            // 2. Skipping the richer API of system-lambda, the point of this.
            Application.main();

            assertThat(context.toString())
                    .isEqualTo("TheFoo(label=I AM FOOCUTUS OF BORG)\n");
        }
    }

    private static ContextForTerminal captureTerminal() {
        return new ContextForTerminal();
    }

    /**
     * Replace stdout/stderr to a terminal with capture to an array of bytes
     * for testing.
     * Messing with UTF-8 and character encodings is (sensibly) required even
     * though our tests are all ASCII, and users wanting a richer API can
     * turn to {@code system-lambda} or other solutions.
     * <p>
     * <b>Note</b>: This is an example of comments in the code that should be
     * pushed up to Javadoc.
     * Generally, if you need to comment something in the code, then push it
     * in the Javadoc and help users read your remarks,
     * or else refactor the code to make the comment irrelevant.
     * The general pattern is "shift problems left", meaning sooner to
     * developers: browsing code advice is much to the left of fixing a
     * problem in production.
     * <p>
     * <b>Note</b>: Pay no attention to the multi-threading issues for
     * parallel tests.
     * This is a concern always and anytime we use stdout and stderr, and
     * also with libraries.
     * Support for older applications on older JVMs that do not assume UTF-8
     * is a challenge for examples.
     */
    @SuppressWarnings({
            "PMD.FinalFieldCouldBeStatic",
            "PMD.CloseResource", // The code is too complex for PMD to follow
    })
    private static class ContextForTerminal implements AutoCloseable {
        /**
         * Combine "stdout" and "stderr" into a single buffer usable in tests.
         * Note that this does not address UTF-8 concerns, so needs wrapping,
         * and additional state.
         */
        private final ByteArrayOutputStream captureOutAndErr =
                new ByteArrayOutputStream();
        /**
         * Remember the original stdout so we can restore after the test.
         */
        private final PrintStream originalOut = System.out;
        /**
         * Remember the original stderr so we can restore after the test.
         */
        private final PrintStream originalErr = System.err;

        ContextForTerminal() {
            final var outAndErr =
                    new PrintStream(captureOutAndErr, true, UTF_8);
            System.setOut(outAndErr);
            System.setErr(outAndErr);
        }

        @Override
        public void close() {
            System.out.close(); // Points to the test-only output stream
            System.err.close(); // Points to the test-only output stream
            System.setOut(originalOut);
            System.setErr(originalErr);
        }

        @Override
        public String toString() {
            return captureOutAndErr.toString(UTF_8);
        }
    }
}
