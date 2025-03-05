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

  imports = [
    ./programs/shell/bash.nix
    ./programs/shell/zsh.nix

    ./programs/tools/git.nix

    ./programs/terminals/wezterm

    ./programs/ide/vscode.nix

    ./programs/browsers/firefox.nix
    ./programs/browsers/librewolf.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs._1password-gui
    pkgs.telegram-desktop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
