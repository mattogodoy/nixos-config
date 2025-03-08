{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [ 
    # Desktop apps
    _1password-gui
    obsidian
    telegram-desktop

    # CLI utils
    ctop
    fzf
    htop
    wget
    zip
  ];
}