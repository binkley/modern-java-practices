package demo;

import java.util.HashSet;
import java.util.Set;

public final class ErrorProneSpike {

    /** Make checkstyle happy. */
    private static final int MAX_NUM_ITERATIONS = 100;

    private ErrorProneSpike() {
        System.out.println("hey");
    }

    /**
     * Main entry point.
     *
     * @param args the command-line arguments
     */
    public static void main(final String[] args) {
        Set<Short> s = new HashSet<>();
        for (short i = 0; i < MAX_NUM_ITERATIONS; i++) {
            s.add(i);
            s.remove(i - 1);
        }
        System.out.println(s.size());
    }
}
