{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    # Add servers to the ssh config file
    matchBlocks = {
      "debian" = {
        hostname = "192.168.1.110";
        user = "matto";
      };

      "raphael" = {
        hostname = "192.168.1.120";
        user = "matto";
      };
    };
  };
}
