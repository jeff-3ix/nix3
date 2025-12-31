{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    
    enableSshSupport = true;       # or false if you want keyring.nix to handle SSH
    sshKeys = [ "FCF10CA3DA4D2C6753394DE4CC5E77ED83E0C031" ];

    defaultCacheTtl = 600;          # example: 10 minutes
    maxCacheTtl = 7200;             # example: 2 hours
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}

