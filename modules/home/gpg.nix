{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    
    enableSshSupport = true;       # or false if you want keyring.nix to handle SSH
   # sshKeys = [ "id_ed25519" ];    # optional: automatically add your SSH key
    # on login

    defaultCacheTtl = 600;          # example: 10 minutes
    maxCacheTtl = 7200;             # example: 2 hours
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}

