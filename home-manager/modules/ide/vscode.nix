{ config, pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
      profiles = {
        default = {
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
          userSettings = {
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
            "editor.rulers" = [80 100];
            "files.trimTrailingWhitespace" = true;
            "files.insertFinalNewline" = true;
            "telemetry.telemetryLevel" = "off";
            "workbench.startupEditor" = "none";
          };
        };
      };
    };
  };
}
