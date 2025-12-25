{ pkgs, ... }:

{
  environment.variables.EDITOR = "vim";

  programs.git.enable = true;

  # Credential storage via Secret Service (GNOME Keyring, etc.)
  environment.systemPackages = [
    pkgs.git-credential-libsecret
  ];

  programs.git.config = {
    credential.helper = "libsecret";
  };
}
