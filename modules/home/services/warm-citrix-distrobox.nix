{ pkgs, pkgsStable, ... }:

{
  systemd.user.services.warm-citrix-distrobox = {
    Unit = {
      Description = "Warm up Fedora Distrobox for Citrix";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;

      # Wait a bit after login so we don't contend with startup
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 10";

      # Start/warm the distrobox without leaving you inside it
      ExecStart = "${pkgsStable.distrobox}/bin/distrobox enter fedora -- ${pkgs.coreutils}/bin/true";

      # Optional: don't hard-fail the session if stop fails
      ExecStop = "-${pkgsStable.podman}/bin/podman stop -t 10 fedora";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
