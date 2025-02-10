{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-air"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        extraConfig = ''
          [main]
          # The Gnome overview does not have a pre-defined key binding
          # It has to be set to CMD + Space manually from the settings
          # scale is F3 key in a mac
          scale = C-space
          
          # dashboard is # F4 key in a mac
          dashboard = M-a

          # Simulate CMD (meta) key in MacOS
          leftmeta = layer(meta_mac)
          rightmeta = layer(meta_mac)

          [meta_mac:C]
          left = home
          right = end

          # Switch directly to an open tab (e.g. Firefox, VS code)
          1 = A-1
          2 = A-2
          3 = A-3
          4 = A-4
          5 = A-5
          6 = A-6
          7 = A-7
          8 = A-8
          9 = A-9

          # Copy
          c = C-insert
          # Paste
          v = S-insert
          # Cut
          x = S-delete

          # As soon as tab is pressed (but not yet released), we switch to the
          # "app_switch_state" overlay where we can handle left, right.
          # Also, send a 'M-tab' key tap before entering app_switch_sate.
          tab = swapm(app_switch_state, M-tab)

          # CMD-º: Switch to next window in the application group
          # For some reason, "º" is detected as "`". See "keyd monitor"
          ` = A-f6

          [app_switch_state:M]
          # CMD-Tab: Switch to next application
          tab = M-tab
          right = M-tab
          left = M-S-tab

          # Simulate move cursor by one word using alt like in MacOS
          [alt]
          left = C-left
          right = C-right
        '';
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matto = {
    isNormalUser = true;
    description = "Matto";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow dinamically linked executables
  programs.nix-ld.enable = true;
}
