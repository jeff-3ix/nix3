{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/boot.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/services-desktop.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/virtualisation.nix

    ../../modules/nixos/packages-cli.nix
    ../../modules/nixos/packages-gui.nix
    ../../modules/nixos/packages-dev.nix

    ../../modules/nixos/environment.nix
    ../../modules/nixos/state-version.nix
  ];
}
