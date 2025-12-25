{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      # ls and eza aliases (requires eza)
      ls = "eza";
      ll = "eza --long";
      la = "eza --all";
      lla = "eza --long --all";
      lt = "eza --tree";
      llt = "eza --long --tree";
      llta = "eza --long --tree --all";
      
      # trashy updates (requires trashy)
      tt = "trash-put";
      tp = "trash-put";
      tl = "trash-list";
      te = "trash-empty";
      
      # nix update aliases
      update = "sudo nixos-rebuild switch";
      up = "sudo nixos-rebuild switch";
      up-test = "sudo nixos-rebuild test";
      
      # git aliases
      gs = "git status";
      gc = "git commit -am";
      gpush = "git push";
      gpull = "git pull";
      
    };
  };
}
