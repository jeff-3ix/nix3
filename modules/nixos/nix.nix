{ ... }:

{
  nixpkgs.config = {
    allowUnfree = true;   # Allow unfree packages
    # allowBroken = true;   # Allow broken packages
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes"];

      download-buffer-size = 268435456; # 256 MiB (16 GB RAM system)

      narinfo-cache-negative-ttl = 300; # 5 minutes

      max-jobs = "auto";
      cores = 0;

      keep-outputs = true;
      keep-derivations = true;

      connect-timeout = 5;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
