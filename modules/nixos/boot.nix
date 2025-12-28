{ pkgs, ... }:

{
  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
    kernelParams = [ "nosgx" ];
    initrd.luks.devices."luks-root".device = "/dev/disk/by-uuid/06eeab67-7475-484b-b82b-139750d1d5e0";
  };

  swapDevices = [
    { device = "/swapfile"; size = 8192; }
  ];
}
