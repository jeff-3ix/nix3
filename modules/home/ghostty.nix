{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableBashIntegration = true;
    
    settings = {
      background-opacity = "0.8";
      font-family = "JetBrainsMono Nerd Font";
     
    };
  };
}
