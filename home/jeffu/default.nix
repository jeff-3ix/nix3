{ ... }:

{
  imports = [
    ../../modules/home/base.nix

    ../../modules/home/packages-cli.nix
    ../../modules/home/packages-gui.nix
    ../../modules/home/packages-dev.nix

    ../../modules/home/ghostty.nix
    ../../modules/home/zoxide.nix
    ../../modules/home/bash.nix
    ../../modules/home/git.nix
    ../../modules/home/starship.nix

    ../../modules/home/services/warm-citrix-distrobox.nix

    # This module contains your existing commented-out dconf stanza (kept verbatim).
    ../../modules/home/dconf-commented.nix
  ];
}
