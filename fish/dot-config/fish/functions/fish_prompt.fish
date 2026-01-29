function fish_prompt
    set -l last_status $pipestatus
    set -l prompt_color (set_color '#b58900')
    set -l error_color (set_color $fish_color_error)
    set -l normal (set_color normal)

    set -l output ""

    # Duration (only if >= 1000ms)
    if test "$CMD_DURATION" -ge 1000
        set -l secs (math --scale=1 $CMD_DURATION/1000 % 60)
        set -l mins (math --scale=0 $CMD_DURATION/60000 % 60)
        set -l hours (math --scale=0 $CMD_DURATION/3600000)
        set -l duration
        test $hours -gt 0 && set -a duration $hours"h"
        test $mins -gt 0 && set -a duration $mins"m"
        test $secs -gt 0 && set -a duration $secs"s"
        set output "$output$duration "
    end

    # Check for errors in pipestatus
    set -l has_error false
    for code in $last_status
        if test $code -ne 0
            set has_error true
            break
        end
    end

    if test "$has_error" = true
        set output "$output$error_color$last_status ❱$normal "
    else
        set output "$output$prompt_color❱$normal "
    end

    echo -n $output
end
