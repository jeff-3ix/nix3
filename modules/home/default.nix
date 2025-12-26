{ ... }:

{
  imports = [
    ./base.nix

    ./packages-cli.nix
    ./packages-gui.nix
    ./packages-dev.nix

    ./vim.nix
    ./ghostty.nix
    ./zoxide.nix
    ./bash.nix
    ./git.nix
    ./starship.nix

    ./services/warm-citrix-distrobox.nix

    # Keep your commented-out dconf stanza module.
    ./dconf-commented.nix
  ];
}

