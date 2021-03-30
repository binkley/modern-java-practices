package demo;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

import javax.annotation.Nonnull;
import java.util.regex.Pattern;

import static java.util.regex.Pattern.CASE_INSENSITIVE;
import static java.util.regex.Pattern.compile;

/** Demonstration class. */
@Getter
@EqualsAndHashCode
@RequiredArgsConstructor
@ToString
public final class TheFoo {
    /** Check for the Borg. */
    private static final Pattern BORG = compile("BORG", CASE_INSENSITIVE);

    /** The foo. */
    @Nonnull
    private final String label;

    /**
     * Is there danger?
     *
     * @return if the ship should go onto red alert
     */
    public boolean isRedAlert() {
        return BORG.matcher(label).find();
    }
}
