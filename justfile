[private]
default:
    @just --list --unsorted

# Format all shell and fish scripts
format:
    #!/usr/bin/env bash
    shopt -s globstar
    shfmt -w -i 4 -ci **/*.sh
    fish_indent -w **/*.fish
