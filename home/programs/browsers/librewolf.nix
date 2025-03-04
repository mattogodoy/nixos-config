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
          "extensions.screenshots.disabled" = lock-true;
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
