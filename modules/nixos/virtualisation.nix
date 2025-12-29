{ pkgs, pkgsStable, ... }:

{
  environment.systemPackages = [
    pkgsStable.distrobox
  ];

  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      package = pkgsStable.podman;

      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = "podman";
  };
}
