{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;

    # Shell integration
    enableFishIntegration = true;
    enableBashIntegration = false;
    enableZshIntegraion = false;

    # Optional background daemon for snappier UX
    daemon.enable = true;

    # Optional Atuin's own config
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      filter_mode = "host";
      enter_accept = true;
    };
  };
}

