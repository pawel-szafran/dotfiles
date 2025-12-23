function zellij_rename_default_tab -d "Rename tab if it has default name" --argument-names new_name
    set focused_tab (zellij action dump-layout 2>/dev/null | rg '^\s*tab .*focus=true')
    if string match -qr 'name="Tab ' -- "$focused_tab"
        zellij action rename-tab $new_name
    end
end
