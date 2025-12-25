{ pkgs, ... }:

{
  home.packages = with pkgs; [
    just
    topgrade
    vimgolf
    hugo
    vscode
  ];
}
