{ ... }:

{
  imports = [
    ./base.nix

    ./keyring.nix

    ./packages-cli.nix
    ./packages-gui.nix
    ./packages-dev.nix

#    ./brave.nix
    ./vim.nix
    ./ghostty.nix
    ./zoxide.nix
    ./fish.nix
    # ./bash.nix
    ./git.nix
    ./starship.nix

    ./services/warm-citrix-distrobox.nix

    ./dconf.nix
  ];
}

