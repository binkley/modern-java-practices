package demo;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * Replaces writing to STDOUT/STDERR with capture to an array of bytes all for
 * testing.
 * <p>
 * One does not usually test STDOUT/STDERR output unless working on a terminal
 * program.
 * This example project does so to demonstrate <em>integration testing</em>.
 * We do not want to focus on complex alternatives (databases, dependency
 * injection, remote REST calls, et al) but it is important to demonstrate
 * contrast between <em>unit tests</em> and <em>integration tests</em> in the
 * build.
 * <p>
 * <b>Note</b>: Mucking with UTF-8/character encodings is required in this
 * code even though our tests are all ASCII, and users wanting a richer API
 * can turn to {@code system-lambda} or similar libraries. Anytime you work
 * with text for humans, keep UTF and encodings in mind.
 * <p>
 * <b>Note</b>: Use of this test helper means: do <b>not</b> run integration
 * tests in parallel: their output to the terminal will become interleaved.
 * This is a concern always and anytime you access STDOUT/STDERR.
 * <b>Note</b>: A recommended pattern is that a class initializes as much as
 * possible in the fields so that the constructor has minimal work.
 *
 * @see TerminalContext#captureTerminal(Runnable) the main entry point for this
 * class
 * @see <a
 * href="https://github.com/stefanbirkner/system-lambda"><code>system-lambda
 * </code> for more sophisticated handling of STDOUT/STDERR</a>
 */
@SuppressWarnings({
        // We follow JVM statics for out and err which confuses PMD
        "PMD.FinalFieldCouldBeStatic",
        // The code is too complex for PMD to follow because of JVM statics
        "PMD.CloseResource",
        // File issue with PMD, and suppress in config.
        // Why is long Javadoc triggering this?
        "PMD.CommentSize"})
public final class TerminalContext implements AutoCloseable {
    /**
     * Combine STDOUT/STDERR into a single buffer usable in tests.
     * <p>
     * Note that this does not address UTF-8 concerns, so needs wrapping,
     * and additional state.
     */
    private final ByteArrayOutputStream captureOutAndErr
            = new ByteArrayOutputStream();
    /**
     * Remember the original STDOUT so we can restore after the test.
     */
    private final PrintStream originalOut = System.out;
    /**
     * Remember the original STDERR so we can restore after the test.
     */
    private final PrintStream originalErr = System.err;

    private TerminalContext() {
        final var outAndErr = new PrintStream(captureOutAndErr, true, UTF_8);
        System.setOut(outAndErr); // NOT thread-safe
        System.setErr(outAndErr); // NOT thread-safe
    }

    /**
     * Runs the call provided to capture STDOUT/STDERR such as {@code main}.
     * Use this in tests to check STDOUT/STDERR, and restore those after the
     * test completes. Note that outut is captured as UTF-8.
     *
     * @param call the method reference or lambda to execute and capture
     * STDOUT/STDERR from
     * @return the captured STDOUT and STDERR as a UTF-8 string, including
     * possibly interleaved output
     */
    public static String captureTerminal(final Runnable call) {
        try (var context = new TerminalContext()) {
            call.run();
            return context.toString();
        }
    }

    @Override
    public void close() {
        final PrintStream wrapper = System.out; // Shared with System.err
        System.setOut(originalOut);
        System.setErr(originalErr);
        wrapper.close();
    }

    @Override
    public String toString() {
        return captureOutAndErr.toString(UTF_8);
    }
}
