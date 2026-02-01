function hx_preview -d "Preview file in tmux popup based on extension"
    set -l file $argv[1]
    switch $file
        case '*.md'
            tmux display-popup -E -w 80% -h 80% -- glow -p $file
    end
end
