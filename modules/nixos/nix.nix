{ ... }:

{
  nixpkgs.config = {
    allowUnfree = true;   # Allow unfree packages
    # allowBroken = true;   # Allow broken packages
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
