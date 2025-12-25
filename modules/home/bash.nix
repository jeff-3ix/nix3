{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
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
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      nr = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";

      # test only
      rebuild-test = "sudo nixos-rebuild test --flake ~/nixos-config#nixos";
      nrt = "sudo nixos-rebuild test --flake ~/nixos-config#nixos";

      # next-boot only
      rebuild-boot = "sudo nixos-rebuild boot --flake ~/nixos-config#nixos";
      nrb = "sudo nixos-rebuild boot --flake ~/nixos-config#nixos";  

      # debugging mode
      nr-trace = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos --show-trace";

      # clean system generations, then clean user generations, then rebuild
      nr-clean = ''
        sudo nix-collect-garbage -d && 
        nix-collect-garbage -d &&
        sudo nixos-rebuild switch --flake ~/nixos-config#nixos
      ''; 

      # deep clean
      nr-nuke = ''
        sudo nix-collect-garbage -d &&
        nix-collect-garbage -d &&
        sudo nix-store --optimise &&
        sudo nixos-rebuild switch --flake ~/nixos-config#nixos
      ''; 
    
      # git aliases
      gs = "git status";
      gc = "git commit -am";
      gpush = "git push";
      gpull = "git pull";
      
    };
  };
}
