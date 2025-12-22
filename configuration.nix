# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
    initrd.luks.devices."luks-06eeab67-7475-484b-b82b-139750d1d5e0".device = "/dev/disk/by-uuid/06eeab67-7475-484b-b82b-139750d1d5e0";
  };

  # Networking
  networking = {
    hostName = "nixos";     # Define your hostname.
    networkmanager.enable = true;   # Enable networking
    firewall = {
      enable = true;  # enable the firewall
      trustedInterfaces = [ "tailscale0" ];  # always allow traffic from your Tailscale network
      allowedUDPPorts = [ config.services.tailscale.port ]; # allow the Tailscale UDP port through the firewall
      #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    };
  };
  
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Services
  services = {
    xserver = {
      enable = true;    # Enable the X11 windowing system
      xkb = {            # Configure the keymap in X11
        layout = "us";
        variant = "";
      };
    };
    displayManager.gdm.enable = true;    # Enable the GNOME desktop environment
    desktopManager.gnome.enable = true;    # Enable the GNOME desktop enviorment
    printing = {
      enable = true;     # Enable CUPS to print documents
      drivers = [ 
        pkgs.hplip
        pkgs.hplipWithPlugin
        pkgs.gutenprint
        pkgs.gutenprintBin
      ];   # Add HP printer drivers
    };
    avahi = {
      enable = true;    # Enable Avahi autodiscovery of printers
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    tailscale = {
      enable = true;        # Enable Tailscale
      useRoutingFeatures = "client";    # allow use of subnet routers/exit nodes. Options are "server", "client", or "both"
    };
    pulseaudio.enable = false;      # Enable sound with pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openssh.enable = true;      # Enable the OpenSSH Daemon
    #xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
  };
  security.rtkit.enable = true;     # Needed for enabling pipewire


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeffu = {
    isNormalUser = true;
    description = "Jeffry Ushupun";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  nixpkgs.config = {
    allowUnfree = true;   # Allow unfree packages
    #allowBroken = true;   # Allow broken packages
  }; 
  
  nix = {
    settings.experimental-features = [ "nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers.backend = "podman";
    oci-containers.containers = {
      container-name = {
        image = "container-image";
        autoStart = true;
        ports = [ "127.0.0.1:1234:1234" ];
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
  git
  vim
  wget
  curl
  lynx
  alacritty
  kitty
  ptyxis
  dracula-theme
  distrobox
  boxbuddy
  #wineWowPackages.stable
  #winetricks
  ];

  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
