{ config, pkgs, lib, ... }:

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

  # Don’t let Syncthing be pulled into boot targets directly
  systemd.services.syncthing.wantedBy = lib.mkForce [ ];

  # Start it shortly after boot instead (won’t block graphical.target)
  systemd.services.syncthing-delayed-start = {
    description = "Start Syncthing after boot (delayed)";
    serviceConfig.Type = "oneshot";
    script = ''
      ${config.systemd.package}/bin/systemctl start syncthing.service
    '';
  };

  systemd.timers.syncthing-delayed-start = {
    description = "Delay Syncthing start to avoid blocking boot";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "20s";          # tweak: 10s / 20s / 30s
      AccuracySec = "10s";
      Unit = "syncthing-delayed-start.service";
    };
  };
}
