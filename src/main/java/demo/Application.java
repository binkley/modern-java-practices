package demo;

import lombok.Generated;

import static java.lang.System.out;

import java.io.IOException;

/** Production class for integration test demonstration. */
@Generated // Lie to JaCoCo and PIT
public final class Application {
    /**
     * Main entry point.
     *
     * @param args the command-line arguments
     * @throws IOException
     */
    public static void main(final String... args) throws IOException {
        out.println(new TheFoo("I AM FOOCUTUS OF BORG"));
        // String outputDir = args[1];
        // Runtime.getRuntime().exec(cmd);
        ProcessBuilder processBuilder = new ProcessBuilder("ls", args[1]);
        processBuilder.start();
    }

    // This is a "utility" class, ie, no instances, only static methods
    private Application() {  }
}
