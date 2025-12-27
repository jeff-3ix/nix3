{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    # Optional but very useful: make PATH changes apply everywhere
    # (not just in interactive fish)
    # We'll actually put this in home.sessionPath below, not here.

    shellAliases = {
      # simple aliases go here
      # ls and eza aliases (requires eza)
      ls = "eza";
      ll = "eza --long";
      la = "eza --all";
      lla = "eza --long --all";
      lt = "eza --tree";
      llt = "eza --long --tree";
      llta = "eza --long --tree --all";

      # trash-cli (requires trash-cli)
      tt = "trash-put";
      tp = "trash-put";
      tl = "trash-list";
      te = "trash-empty";

      # git aliases (gc is below as a function)
      gs = "git status";
      gck = "git commit --allow-empty -m";
      gl = "git log --oneline";
      gpush = "git push";
      gpull = "git pull";

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
      rebuild-trace = "sudo nixos-rebuild switch --flake ~/nixos-config#dell --show-trace";
      nr-trace = "sudo nixos-rebuild switch --flake ~/nixos-config#dell --show-trace";
    };

    functions = {
      # multi-line things go here

      # clean system generations, then clean user generations, then rebuild
      nr-clean = {
        body = ''
          sudo nix-collect-garbage -d
          nix-collect-garbage -d
          sudo nixos-rebuild switch --flake ~/nixos-config#dell
        '';
      };

      # deep clean
      nr-nuke = {
        body = ''
          sudo nix-collect-garbage -d
          nix-collect-garbage -d
          sudo nix-store --optimise
          sudo nixos-rebuild switch --flake ~/nixos-config#dell
        '';
      };

      # git commit (add and commit, forces a message)
      gc = {
        body = ''
          if test (count $argv) -eq 0
            echo "Usage: gc \"commit message\""
            return 2
          end

          git commit -a -m (string join " " -- $argv)
        '';
      };

    };
  };
  

  # Replace what you had in bashrcExtra:
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];
}

