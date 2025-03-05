{
  programs = {
    bash = {
      enable = true;
      shellAliases = {
        # NixOS
        hms = "cd ~/.dotfiles && home-manager switch --flake .";
        nrs = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .";

        # Terminal
        ll = "ls -lah";

        # Development
        arduino = "nix develop github:xdadrm/nixos_use_platformio_patformio-ide_and_vscode";

        # Git
        gs = "git status";
        gd = "git diff";
        gc = "git commit -a -m";
      };
    };
  };
}
