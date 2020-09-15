brew cask install visual-studio-code

set vscode_config_dir ~/Library/Application\ Support/Code/User
symlink settings.json $vscode_config_dir
symlink keybindings.json $vscode_config_dir
set -e vscode_config_dir

set extensions                                \
  eamodio.gitlens                             \
  slevesque.vscode-multiclip                  \
  dbankier.vscode-quick-select                \
  ms-vsliveshare.vsliveshare                  \
  stkb.rewrap                                 \
                                              \
  redhat.vscode-yaml                          \
  bungcip.better-toml                         \
  fcrespo82.markdown-table-formatter          \
                                              \
  sibiraj-s.vscode-scss-formatter             \
                                              \
  skyapps.fish-vscode                         \
                                              \
  JakeBecker.elixir-ls                        \
  pgourlain.erlang                            \
                                              \
  humao.rest-client                           \
                                              \
  ms-azuretools.vscode-docker                 \
  ms-kubernetes-tools.vscode-kubernetes-tools

for extension in $extensions
  code --install-extension $extension
end

set -e extensions
