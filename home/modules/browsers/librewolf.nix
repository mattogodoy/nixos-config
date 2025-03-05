{ config, pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs = {
    librewolf = {
      enable = true;
      settings = {
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "browser.sessionstore.resume_from_crash" = true;
      };
      policies = {
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        ExtensionSettings = with builtins;
        let extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
        in listToAttrs [
          (extension "1password-x-password-manager" "{d634138d-c276-4fc8-924b-40a0ea21d284}")
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "darkreader" "addon@darkreader.org")
          (extension "raindropio" "raindrop@raindrop.io")
          (extension "kagi-search-for-firefox" "kagi_search@kagi.com")
          (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
          (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "dearrow" "deArrow@ajay.app")
          (extension "auto-tab-discard" "auto-tab-discard@moisseev.dev")
        ];

        /* ---- PREFERENCES ---- */
        # Set preferences shared by all profiles.
        Preferences = { 
          "browser.tabs.groups.enabled" = lock-true;
          "browser.startup.page" = 3; # This is not documented: "Open previous windows and tabs"
          "browser.ctrlTab.sortByRecentlyUsed" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          #"pref.privacy.disable_button.cookie_exceptions" = lock-false;
        };
      };

      /* ---- PROFILES ---- */
      # Switch profiles via about:profiles page.
      # For options that are available in Home-Manager see
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      profiles = {
        matto = {               # the profile name
          id = 0;               # 0 is the default profile; see also option "isDefault"
          name = "matto";       # name as listed in about:profiles
          isDefault = true;     # can be omitted; true if profile ID is 0
          search = {
            force = true;
            default = "Kagi";
            privateDefault = "DuckDuckGo";
            order = ["Kagi" "DuckDuckGo" "Google"];
            engines = {
              "Kagi" = {
                urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
                iconUpdateURL = "https://kagi.com/favicon.ico";
              };

              "OpenStreetMap" = {
                urls = [{
                  template = "https://openstreetmap.org/search";
                  params = [
                  { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "${pkgs.fetchurl {
                  url = "https://wiki.openstreetmap.org/w/images/7/79/Public-images-osm_logo.svg";
                  sha256 = "7afb5dc08cde400274e7405fda6324a6514c4f957227b659f9c8aaea4d59a899";
                }}";
                definedAliases = [ "@map" ];
              };

              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      { name = "channel"; value = "unstable"; }
                      { name = "query"; value = "{searchTerms}"; }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nixpkgs" ];
              };

              "NixOptions" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      { name = "query";   value = "{searchTerms}"; }
                      { name = "channel"; value = "unstable"; }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@options" ];
              };

              "MyNixOs (configurations overview)" = {
                urls = [
                  {
                    template = "https://mynixos.com/search";
                    params = [
                      { name = "q"; value = "{searchTerms}"; }
                    ];
                  }
                ];
                icon = "${pkgs.fetchurl {
                  url = "https://mynixos.com/favicon-32x32.png";
                  sha256 = "2b9301ff8dfbc359dbe6793ea6fc3eaa5815e0d01256e505aebbd76a3f5e84b6";
                }}";
                definedAliases = [ "@mynixos" ];
              };

              "Bing".metaData.hidden = true;
            };
          };
          bookmarks = {};
          settings = {          # specify profile-specific preferences here; check about:config for options
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          };
        };
      };
    };
  };
}
