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
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value= true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;

          /* ---- EXTENSIONS ---- */
          # ExtensionSettings = {
          #   "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          #   # uBlock Origin:
          #   "uBlock0@raymondhill.net" = {
          #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          #     installation_mode = "force_installed";
          #   };
          #   # add extensions here...
          # };
          ExtensionSettings = with builtins;
          let extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
          in listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "sponsorblock" "sponsorBlocker@ajay.app")
            (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
            (extension "1password-x-password-manager" "{d634138d-c276-4fc8-924b-40a0ea21d284}")
            (extension "darkreader" "addon@darkreader.org")
            (extension "violentmonkey" "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}")
            (extension "dearrow" "deArrow@ajay.app")
            (extension "auto-tab-discard" "auto-tab-discard@moisseev.dev")
            (extension "kagi-search-for-firefox" "kagi_search@kagi.com")
            (extension "raindropio" "raindrop@raindrop.io")
          ];
  
          /* ---- PREFERENCES ---- */
          # Set preferences shared by all profiles.
          Preferences = { 
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "extensions.pocket.enabled" = lock-false;
            "extensions.screenshots.disabled" = lock-true;
            "browser.topsites.contile.enabled" = lock-false;
            "browser.formfill.enable" = lock-false;
            "browser.search.suggest.enabled" = lock-false;
            "browser.search.suggest.enabled.private" = lock-false;
            "browser.urlbar.suggest.searches" = lock-false;
            "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
            "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
            "browser.newtabpage.activity-stream.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          };
        };
      };

      /* ---- PROFILES ---- */
      # Switch profiles via about:profiles page.
      # For options that are available in Home-Manager see
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      # profiles = {
      #   matto = {               # the profile name
      #     id = 0;               # 0 is the default profile; see also option "isDefault"
      #     name = "matto"        # name as listed in about:profiles
      #     isDefault = true;     # can be omitted; true if profile ID is 0
      #     search = {
      #       force = true;
      #       default = "Kagi";
      #       privateDefault = "DuckDuckGo";
      #       order = ["Kagi" "DuckDuckGo" "Google"];
      #       engines = {
      #         "Kagi" = {
      #           urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
      #           iconUpdateURL = "https://kagi.com/favicon.ico";
      #         };
      #         "Bing".metaData.hidden = true;
      #       };
      #     };
      #     bookmarks = {};
      #     settings = {          # specify profile-specific preferences here; check about:config for options
      #       "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
      #       "browser.startup.homepage" = "https://nixos.org";
      #       "browser.newtabpage.pinned" = [{
      #         title = "NixOS";
      #         url = "https://nixos.org";
      #       }];
      #       # add preferences for matto here...
      #     };
      #   };
      #   profile_1 = {
      #     id = 1;
      #     name = "profile_1";
      #     isDefault = false;
      #     settings = {
      #       "browser.newtabpage.activity-stream.feeds.section.highlights" = true;
      #       "browser.startup.homepage" = "https://ecosia.org";
      #       # add preferences for profile_1 here...
      #     };
      #   };
      # # add profiles here...
      # };
    };
  };
}



# Delete when I get it working

# # Configure Firefox policies
    # package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    #   extraPolicies = {
    #     ExtensionSettings = {
    #       # Block all other extensions
    #       "*".installation_mode = "blocked";

    #       # Allow and force-install uBlock Origin
    #       "uBlock0@raymondhill.net" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # SponsorBlock
    #       "sponsorBlocker@ajay.app" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # Privacy Badger
    #       "jid1-MnnxcxisBPnSXQ@jetpack" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # 1Password
    #       "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # Dark Reader
    #       "addon@darkreader.org" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # Violent Monkey
    #       "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # DeArrow
    #       "deArrow@ajay.app" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/dearrow/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # Auto Tab Discard
    #       "auto-tab-discard@moisseev.dev" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/auto-tab-discard/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # Kagi Search
    #       "kagi_search@kagi.com" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/kagi-search-for-firefox/latest.xpi";
    #         installation_mode = "force_installed";
    #       };

    #       # Raindrop.io
    #       "raindrop@raindrop.io" = {
    #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/raindropio/latest.xpi";
    #         installation_mode = "force_installed";
    #       };
    #     };
    #   };
    # };
    # # profiles.default = {
    # #   extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
    # #     ublock-origin
    # #     darkreader
    # #   ];
    # # };
