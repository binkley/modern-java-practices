package demo;

import lombok.Generated;

import static java.lang.System.out;

/**
 * TODO: <ul>
 * <li>Example <em>Integration Test</em> with this class as the CUT</li>
 * <li>Provide a different class to demonstrate use of {@code @Generated}</li>
 * </ul>
 */
@Generated // Lie to JaCoCo
public class Application {
    public static void main(String[] args) {
        out.println(new DoTheFoo("I AM FOOCUTUS OF BORG"));
    }
}
