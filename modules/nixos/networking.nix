{ config, lib, ... }:

{
  # Networking
  networking = {
    hostName = "dell";     # Define your hostname.
    networkmanager = {
      enable = true;   # Enable networking
    };
    firewall = lib.mkIf config.services.tailscale.enable {
      enable = true;  # enable the firewall
      trustedInterfaces = [ "tailscale0" ];  # always allow traffic from your Tailscale network
      allowedUDPPorts = [ config.services.tailscale.port ]; # allow the Tailscale UDP port through the firewall
      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    };
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    ModemManager = {
      enable = false;
      wantedBy = lib.mkForce [ ];
    };
  };
 
}
