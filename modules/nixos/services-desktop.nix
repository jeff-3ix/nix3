{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    cups-pk-helper
  ];

  # Services
  services = {
    xserver = {
      enable = true;    # Enable the X11 windowing system

      xkb = {            # Configure the keymap in X11
        layout = "us";
        variant = "";
      };
    };

    xdg.portal = {    # Disable the crashing GNOME portal backend
      enable = true;
      extraPortals = [ ];
    };

    desktopManager.gnome.enable = true;

    displayManager.gdm.enable = true;

    displayManager.autoLogin = {
      enable = true;
      user = "jeffu";
    };

    gnome.gnome-keyring.enable = true;
    
    openssh.enable = true;      # Enable the OpenSSH Daemon
    # xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).

    printing = {
      enable = true;    # Enable CUPS to print documents
      browsed.enable = false;
      drivers = [ ];
      listenAddresses = [ "localhost:631" ];
      allowFrom = [ "localhost" ];
      browsing = false;
      defaultShared = false;
      openFirewall = false;
    };

    ipp-usb.enable = false;
    
    avahi = {
      enable = false;  # Enable Avahi autodiscovery of printers (off bc using CUPS)
      nssmdns4 = false;
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

  security = {
    rtkit.enable = true;     # Needed for enabling pipewire
    pam.services = {
      login.enableGnomeKeyring = true;
      gdm.enableGnomeKeyring = true;
    };
    polkit.enable = true;
  };

  # Don't let the bluetooth systemd unit be pulled into boot targets
  systemd.services.bluetooth.wantedBy = lib.mkForce [];

  # Explicitly disable GNOME's portal implementation
  systemd.user.services.xdg-desktop-portal-gnome.enable = false;

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