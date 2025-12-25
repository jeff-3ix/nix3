{ ... }:

{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers.backend = "podman";
    oci-containers.containers = {
      container-name = {
        image = "container-image";
        autoStart = true;
        ports = [ "127.0.0.1:1234:1234" ];
      };
    };
  };
}
