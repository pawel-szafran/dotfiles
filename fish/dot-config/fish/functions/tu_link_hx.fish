function tu_link_hx -d "Symlink hx from home Rust installation"
    set -l hx_src ~/.local/share/mise/installs/rust/(mise current -C ~ rust)/bin/hx
    set -l hx_dst ~/.local/bin/hx

    if not test -e $hx_src
        echo "Error: hx not found at $hx_src"
        return 1
    end

    ln -sf $hx_src $hx_dst
    echo "Linked: $hx_dst -> $hx_src"
end
