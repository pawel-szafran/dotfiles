#!/usr/bin/env bash

bail() {
    echo "$1"
    echo
    printf '\033[90m[Press any key to close]\033[0m'
    read -n 1 -s -r
    exit "${2:-1}"
}
