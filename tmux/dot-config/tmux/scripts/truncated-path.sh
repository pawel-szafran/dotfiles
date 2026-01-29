#!/usr/bin/env bash
path="$1"
home="$HOME"

# Replace home with ~
path="${path/#$home/\~}"

# Split into segments
IFS='/' read -ra segments <<< "$path"

# Build output
result=""
last_idx=$((${#segments[@]} - 1))
[[ "$path" == /* ]] && result="/"

for i in "${!segments[@]}"; do
    seg="${segments[$i]}"
    [ -z "$seg" ] && continue
    
    if [ "$i" -eq "$last_idx" ]; then
        # Basename: full name
        result+="$seg"
    else
        # Truncate to 1 char
        result+="${seg:0:1}/"
    fi
done

echo "$result"
