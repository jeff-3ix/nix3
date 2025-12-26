{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;

    user = "jeffu";
    group = "users";

    dataDir = "/home/jeffu/.config/syncthing";
    configDir = "/home/jeffu/.config/syncthing";

    openDefaultPorts = false;

    settings = {
      gui = {
        enabled = true;
        address = "127.0.0.1:8384";
      };
    };
  };
}

