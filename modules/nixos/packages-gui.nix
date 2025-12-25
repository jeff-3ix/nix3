{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ptyxis
    dracula-theme
    boxbuddy
    wineWowPackages.stable
    winetricks
  ];
}
