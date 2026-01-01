{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    
    enableSshSupport = true;       # or false if you want keyring.nix to handle SSH
    sshKeys = [ "FCF10CA3DA4D2C6753394DE4CC5E77ED83E0C031" ];

    defaultCacheTtl = 86400;          # 24 hours 
    maxCacheTtl = 604800;             # 7 days
    pinentry.package = pkgs.pinentry-gnome3;
  };
}

