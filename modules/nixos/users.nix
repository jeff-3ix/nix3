{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeffu = {
    isNormalUser = true;
    description = "Jeffry Ushupun";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}
