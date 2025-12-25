{ pkgs, ... }:

{
  home.packages = with pkgs; [
    just
    topgrade
    vscode
  ];
}
