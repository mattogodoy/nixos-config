{
  imports = [
    ./shell/bash.nix
    ./shell/zsh.nix

    ./tools/git.nix
    ./tools/ssh.nix

    ./terminals/wezterm

    ./ide/vscode.nix

    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./browsers/librewolf.nix
  ];
}
