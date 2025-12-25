{ pkgs, ... }:

{
  systemd.user.services.warm-citrix-distrobox = {
    Unit = {
      Description = "Warm up Fedora Distrobox for Citrix";
      # Works across most DEs that support systemd user sessions
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.podman}/bin/podman start fedora";
      ExecStop = "${pkgs.podman}/bin/podman stop -t 10 fedora";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
