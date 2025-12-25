{ pkgs, ... }:

{
  # Services
  services = {
    xserver = {
      enable = true;    # Enable the X11 windowing system

      xkb = {            # Configure the keymap in X11
        layout = "us";
        variant = "";
      };
    };

    desktopManager.gnome.enable = true;

    displayManager.gdm.enable = true;

    displayManager.autoLogin = {
      enable = true;
      user = "jeffu";
    };

    openssh.enable = true;      # Enable the OpenSSH Daemon
    # xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
  };

  programs.firefox.enable = true;

  services.printing = {
    enable = true;     # Enable CUPS to print documents
    drivers = [
      pkgs.hplip
      pkgs.hplipWithPlugin
      pkgs.gutenprint
      pkgs.gutenprintBin
    ];   # Add HP printer drivers
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };

  services.avahi = {
    enable = true;    # Enable Avahi autodiscovery of printers
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.tailscale = {
    enable = true;        # Enable Tailscale
    useRoutingFeatures = "client";    # allow use of subn...et routers/exit nodes. Options are "server", "client", or "both"
  };

  # nextdns = {
  #   enable = true;
  #   arguments = [ "-config" "8c527c" "-cache-siz" "10MB" ];
  # };

  services.pulseaudio.enable = false;      # Enable sound with pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;     # Needed for enabling pipewire
}
