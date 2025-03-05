{ config, pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
      extensions = [
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.arrterian.nix-env-selector
      ];
      keybindings = [
        {
          key = "ctrl+backspace";
          command = "editor.action.deleteLines";
          when = "textInputFocus && !editorReadonly";
        }
      ];
    };
  };
}
