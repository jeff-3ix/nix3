{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

      # fzf keybindings & completion
      eval "$(fzf --bash)"
    '';

    initExtra = ''
      # Load blesh
      source ${pkgs.blesh}/share/blesh/ble.sh

      # blesh behavior tweaks
      bleopt complete_auto_menu=1
      bleopt complete_menu_color=1
      bleopt history_share=1

      # Readline settings (some may be superseded by ble.sh)
      bind 'set completion-ignore-case on'
      bind '"\t":menu-complete'
      bind '"\e[Z":menu-complete-backward'
      bind 'set show-all-if-ambiguous on'
      bind 'set completion-query-items 200'
      bind 'set page-completions on'
    '';

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
      # normal rebuild
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#dell";
      nr = "sudo nixos-rebuild switch --flake ~/nixos-config#dell";

      # test only
      rebuild-test = "sudo nixos-rebuild test --flake ~/nixos-config#dell";
      nrt = "sudo nixos-rebuild test --flake ~/nixos-config#dell";

      # next-boot only
      rebuild-boot = "sudo nixos-rebuild boot --flake ~/nixos-config#dell";
      nrb = "sudo nixos-rebuild boot --flake ~/nixos-config#dell";  

      # debugging mode
      nr-trace = "sudo nixos-rebuild switch --flake ~/nixos-config#dell --show-trace";

      # clean system generations, then clean user generations, then rebuild
      nr-clean = ''
        sudo nix-collect-garbage -d && 
        nix-collect-garbage -d &&
        sudo nixos-rebuild switch --flake ~/nixos-config#dell
      ''; 

      # deep clean
      nr-nuke = ''
        sudo nix-collect-garbage -d &&
        nix-collect-garbage -d &&
        sudo nix-store --optimise &&
        sudo nixos-rebuild switch --flake ~/nixos-config#dell
      ''; 
    
      # git aliases
      gs = "git status";
      gc = "git commit -am";
      gck = "git commit --allow-empty -m";
      gl = "git log --oneline";  # can use with '--grep' or '-#' for number of logs
      gpush = "git push";
      gpull = "git pull";
      
    };
  };
}
