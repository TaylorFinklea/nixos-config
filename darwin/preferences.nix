{ config, lib, pkgs, ... }:
let
  vars = import ../vars.nix;
in {
  # networking.dns = [ "1.1.1.1" "8.8.8.8" ];

  # Auto upgrade nix package and the daemon service.

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 4;

    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        # "com.apple.sound.uiaudio.enabled" = 0;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 60;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        Dragging = true;
        # TrackpadRightClick = true;
        # TrackpadThreeFingerDrag = true;
      };
      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };
      CustomUserPreferences = {
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
          AppleHighlightColor = "0.094118 0.792157 0.901961";
          AppleAccentColor = 4;
        };
        "com.apple.finder" = {
          DisableAllAnimations = false;
          ShowExternalHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
        };
        "com.apple.NetworkBrowser" = {
          BrowseAllInterfaces = 1;
        };
        "com.apple.DesktopServices" = {
          DSDontWriteNetworkStores = true;
        };

        # Reduce Motion Effects
        "com.apple.Accessibility" = {
          ReduceMotionEnabled = 1;
        };
        # "com.apple.universalaccess" = {
        #   reduceMotion = 1;
        # };

        # "com.apple.Safari" = {
        #   AutoOpenSafeDownloads = false;
        #   IncludeDevelopMenu = true;
        #   WebKitDeveloperExtrasEnabledPreferenceKey = true;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        # };
        # "com.apple.mail" = {
        #   AddressesIncludeNameOnPasteboard = false;
        # };

        # Shottr
        "cc.ffitch.shottr" = {
          growingToolbar = 1;
          showIntro = 2009463689;
        };

      };

    };
  };
}
