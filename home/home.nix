{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matto";
  home.homeDirectory = "/home/matto";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # imports = [
  #   ./home/programs/browsers/firefox.nix
  # ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs._1password-gui
    pkgs.telegram-desktop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lah";
      hms = "cd ~/.dotfiles && home-manager switch --flake .";
      nrs = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .";
      arduino = "nix develop github:xdadrm/nixos_use_platformio_patformio-ide_and_vscode";
    };
  };

  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "browser.sessionstore.resume_from_crash" = true;
    };
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Matto Godoy";
    userEmail = "mattogodoy@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
      pkgs.vscode-extensions.arrterian.nix-env-selector
    ];
  };
}
