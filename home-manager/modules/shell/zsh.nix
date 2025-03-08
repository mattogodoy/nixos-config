{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      #autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;

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

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" "zsh-autosuggestions" "powerlevel10k" ];
        theme = "robbyrussell";
      };
    };
  };
}
