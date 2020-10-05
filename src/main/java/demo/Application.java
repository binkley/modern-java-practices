package demo;

import lombok.Generated;
import lombok.experimental.UtilityClass;

import static java.lang.System.out;

/** Production class for integration test demonstration. */
@Generated // Lie to JaCoCo
// Checkstyle does not grok Lombok generated code
@SuppressWarnings("checkstyle:hideutilityclassconstructor")
@UtilityClass
public class Application {
    /**
     * Main entry point.
     *
     * @param args the command-line arguments
     */
    public static void main(final String... args) {
        out.println(new DoTheFoo("I AM FOOCUTUS OF BORG"));
    }
}
