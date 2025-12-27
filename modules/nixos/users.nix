{ pkgs, ... }:

{
  # Enable fish system-wide (makes it a valid login shell)
  programs.fish.enable = true;

  # Define a user account
  users.users.jeffu = {
    isNormalUser = true;
    description = "Jeffry Ushupun";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };
}
