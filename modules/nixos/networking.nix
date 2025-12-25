{ config, ... }:

{
  # Networking
  networking = {
    hostName = "nixos";     # Define your hostname.
    networkmanager.enable = true;   # Enable networking
    firewall = {
      enable = true;  # enable the firewall
      trustedInterfaces = [ "tailscale0" ];  # always allow traffic from your Tailscale network
      allowedUDPPorts = [ config.services.tailscale.port ]; # allow the Tailscale UDP port through the firewall
      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    };
  };
}
