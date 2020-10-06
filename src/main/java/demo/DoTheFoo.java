package demo;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

import static java.util.Objects.isNull;

/** Demonstration class. */
@Getter
@EqualsAndHashCode
@RequiredArgsConstructor
@ToString
public final class DoTheFoo {
    /** The foo. */
    private final String foo;

    /**
     * Checks if {@link #foo} is valuable.
     *
     * @return {@code true} if empty
     */
    public boolean isEmpty() {
        return isNull(foo);
    }
}
