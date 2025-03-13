{
  programs.chromium = {
    enable = true;
    extensions = [
      # Dark Reader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }

      # uBlock Origin
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }

      # 1Password – Password Manager
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; }
    ];
  };
}
