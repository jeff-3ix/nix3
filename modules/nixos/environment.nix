{ pkgs, ... }:

{
  environment.variables.EDITOR = "vim";

  # Use gitFull so the libsecret credential helper is available
  programs.git.enable = true;
  environment.systemPackages = [
    pkgs.gitFull
  ];

  programs.git.config = {
    # Tell git where the helper binary lives (gitFull provides it)
    credential.helper = "${pkgs.gitFull}/libexec/git-core/git-credential-libsecret";
  };
}
