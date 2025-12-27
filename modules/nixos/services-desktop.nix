{ pkgs, lib, ... }:

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

    printing = {
      enable = true;    # Enable CUPS to print documents
      drivers = [
        pkgs.hplip
        pkgs.hplipWithPlugin
      ];
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
    };

    avahi = {
      enable = true;  # Enable Avahi autodiscovery of printers
      nssmdns4 = true;
      openFirewall = true;
      publish.enable = true;
      publish.userServices = true;
    };

    tailscale = {
      enable = true;
      useRoutingFeatures = "client";  # allow use of subnet routers / exit nodes
    };

    pulseaudio.enable = false;    # Enable sound with pipewire

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman.enable = false;   # Change to true to allow tray & agent on GNOME
  };

  programs.firefox.enable = true;

  # nextdns = {
  #   enable = true;
  #   arguments = [ "-config" "8c527c" "-cache-siz" "10MB" ];
  # };

  security.rtkit.enable = true;     # Needed for enabling pipewire

  # Don't let the bluetooth systemd unit be pulled into boot targets
  systemd.services.bluetooth.wantedBy = lib.mkForce [];

  # Prevent the kernel driver from probing the device at boot
  boot.blacklistedKernelModules = [ "btusb" ];

  # Hardware
  # Enable bluetooth (but prevent systemd and blueman from autostart - see above)
  # To start bluetooth: 'sudo bluetoothctl power on && sudo systemctl start bluetooth'
  # To stop bluetooth: 'sudo systemctl stop bluetooth'
  hardware.bluetooth = {
    enable = true;   
    powerOnBoot = false;
  };
}