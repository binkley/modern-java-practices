package demo;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * Replaces STDOUT/STDERR to a terminal with capture to an array of bytes
 * for testing.
 * <p>
 * One does not usually test STDOUT/STDERR output unless working on a terminal
 * program.
 * This example project does so to demonstrate <em>integration testing</em> as
 * there are no complex interactions to otherwise test in the project, but it
 * is important to demonstrate constrasting tests between <em>unit tests</em>
 * and <em>integration tests</em>.
 * <p>
 * Messing with UTF-8 and character encodings is (sensibly) required even
 * though our tests are all ASCII, and users wanting a richer API can
 * turn to {@code system-lambda} or similar libraries.
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
 * This is a concern always and anytime we use STDOUT/STDERR, and also
 * with libraries.
 * Support for older applications on older JVMs that do not assume UTF-8
 * is a challenge for examples.
 *
 * @see <a
 * href="https://github.com/stefanbirkner/system-lambda">system-lambda</a>
 */
@SuppressWarnings({
        // We follow JVM statics for out and err which confuses PMD
        "PMD.FinalFieldCouldBeStatic",
        // The code is too complex for PMD to follow because of JVM statics
        "PMD.CloseResource",
        "PMD.CommentSize" // Complain to PMD, and suppress in config
})
final class TerminalContext implements AutoCloseable {
    /**
     * Combine STDOUT/STDERR into a single buffer usable in tests.
     * <p>
     * Note that this does not address UTF-8 concerns, so needs wrapping,
     * and additional state.
     */
    private final ByteArrayOutputStream captureOutAndErr =
            new ByteArrayOutputStream();
    /**
     * Remember the original STDOUT so we can restore after the test.
     */
    private final PrintStream originalOut = System.out;
    /**
     * Remember the original STDERR so we can restore after the test.
     */
    private final PrintStream originalErr = System.err;

    private TerminalContext() {
        final var outAndErr =
                new PrintStream(captureOutAndErr, true, UTF_8);
        System.setOut(outAndErr);
        System.setErr(outAndErr);
    }

    /**
     * Wrapper method for a cleaner API.
     * <p>
     * If {@code TerminalContext} is used for other tests, this method
     * should be moved into that class as a public static for tests to call.
     *
     * @param call typically a method reference or a lambda
     * @return the captured STDOUT and STDERR
     */
    static String captureTerminal(final Runnable call) {
        try (var context = new TerminalContext()) {
            call.run();
            return context.toString();
        }
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
