{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.noto
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    pika-backup
    obsidian
    libreoffice-fresh
    thunderbird
    tailscale
    syncthing
    brave
    mullvad-browser
    zoom-us
    protonmail-desktop
    protonvpn-gui
    proton-pass
    vlc
    freetube
    citrix_workspace
  ];
}
