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
public final class TheFoo {
    /** The foo. */
    private final String label;

    /**
     * Checks if {@link #label} is valuable.
     *
     * @return {@code true} if empty
     */
    public boolean isEmpty() {
        return isNull(label);
    }
}
