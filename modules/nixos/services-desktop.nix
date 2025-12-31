{ pkgs, pkgsStable, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    cups-pk-helper
    evince
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    displayManager.autoLogin = {
      enable = false;   # Auto-login was causing issues w/ keyring
      user = "jeffu";
    };

    gnome.gnome-keyring.enable = true;
    openssh.enable = true;

    printing = {
      enable = true;
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
      enable = false;
      nssmdns4 = false;
    };

    tailscale = {
      enable = true;
      useRoutingFeatures = "client";

      package = pkgsStable.tailscale;
    };

    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman.enable = false;
  };

  programs.firefox.enable = true;

  security = {
    rtkit.enable = true;
    pam.services = {
      login.enableGnomeKeyring = true;
      gdm.enableGnomeKeyring = true;
    };
    polkit.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ "gtk" "gnome" ];
        "org.freedesktop.impl.portal.Print" = "gtk";
      };
    };
  };

  systemd.services.bluetooth.wantedBy = lib.mkForce [];
  boot.blacklistedKernelModules = [ "btusb" ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
