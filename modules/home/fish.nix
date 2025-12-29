{ pkgs, ... }:

let 
  # Need to change if ever moving repo #
  nixosConfigDir = "$HOME/nixos-config";
in
{
  programs.fish = {
    enable = true;

    # Aliases: stable behavior changes (don't edit after expansion)
    shellAliases = {
      
      # eza replaces ls-family aliases (requires eza)
      ls = "eza";
      ll = "eza --long";
      la = "eza --all";
      lla = "eza --long --all";
      lt = "eza --tree";
      llt = "eza --long --tree";
      llta = "eza --long --tree --all";
    };

    # Abbreviations: shortcuts that expand in CLI
    shellAbbrs = {
      
      # trash-cli (requires trash-cli)
      tt = "trash-put";
      tp = "trash-put";
      tl = "trash-list";
      te = "trash-empty";

      # git
      g = "git";
      gs = "git status";
      gl = "git log --oneline";
      gpull = "git pull";
      gpush = "git push";
      gck = "git commit --allow-empty -m";  # still type commit message

      # nix navigation / info
      nc = "cd ${nixosConfigDir}";
      nf = "nix flake";
      nfu = "nix flake update";
      nfm = "nix flake metadata";

      # rebuild entrypoints (functions below)
      # --- rebuilds using CURRENT flake.lock (no updates) ---
      nr = "nr";  # switch (no update)
      nrt = "nrt";  # test (no update)
      nrb = "nrb";  # boot (no update)
      nrd = "nrd";  # dry-run (no update)
      nrtrace = "nrtrace";

      # update + rebuild (functions below)

      # --- update pinned inputs, then rebuild ---
      # Most common “weekly update”: update nixpkgs only (keeps other inputs stable)
      nru = "nru";  # update nixpkgs then switch

      # “Tinker mode”: update everything
      nrua = "nrua";  # update all inputs then switch

      # cleanup flows (functions below)
      nrclean = "nrclean";
      nrnuke = "nrnuke";

      # rollback / generations
      nrl = "nrl";
      nrr = "nrr";

      # find IP (with location)
      myip = "curl ipinfo.io";
    };


    functions = {
      # --- internal helpers ---

      __nixos_cd_or_fail = {
        body = ''
          if not test -d ${nixosConfigDir}
            echo "Missing ${nixosConfigDir}" >&2
            return 1
          end
          cd ${nixosConfigDir}
        '';
      };

      __nixos_target = {
        body = ''
          # Hostname-based target avoids hardcoding #dell in every command.
          set -l host (hostname | string trim)
          echo "${nixosConfigDir}#$host"
        '';
      };


      # --- rebuilds using CURRENT flake.lock (no updates) ---

      nr = {
        description = "nixos-rebuild switch using current flake.lock";
        body = ''
          __nixos_cd_or_fail; or return
          set -l target (__nixos_target)
          sudo nixos-rebuild switch --flake "$target" $argv
        '';
      };

      nrt = {
        description = "nixos-rebuild test using current flake.lock";
        body = ''
          __nixos_cd_or_fail; or return
          set -l target (__nixos_target)
          sudo nixos-rebuild test --flake "$target" $argv
        '';
      };

      nrb = {
        description = "nixos-rebuild boot using current flake.lock";
        body = ''
          __nixos_cd_or_fail; or return
          set -l target (__nixos_target)
          sudo nixos-rebuild boot --flake "$target" $argv
        '';
      };

      nrd = {
        description = "nixos-rebuild dry-run using current flake.lock";
        body = ''
          __nixos_cd_or_fail; or return
          set -l target (__nixos_target)
          sudo nixos-rebuild dry-run --flake "$target" $argv
        '';
      };

      nrtrace = {
        description = "nixos-rebuild switch with --show-trace";
        body = ''
          nr --show-trace $argv
        '';
      };

      # --- update pinned inputs, then rebuild ---

      # Most common “weekly update”: update nixpkgs only (keeps other inputs stable)
      nru = {
        description = "Update nixpkgs input (flake.lock) then switch";
        body = ''
          __nixos_cd_or_fail; or return
          nix flake lock --update-input nixpkgs
          nr $argv
        '';
      };

      # “Tinker mode”: update everything
      nrua = {
        description = "Update ALL flake inputs then switch";
        body = ''
          __nixos_cd_or_fail; or return
          nix flake update
          nr $argv
        '';
      };

      # --- cleanup flows ---

      nrclean = {
        description = "Collect garbage (system + user) then switch";
        body = ''
          sudo nix-collect-garbage -d
          nix-collect-garbage -d
          nr $argv
        '';
      };

      nrnuke = {
        description = "Deep clean + optimise store then switch";
        body = ''
          sudo nix-collect-garbage -d
          nix-collect-garbage -d
          sudo nix-store --optimise
          nr $argv
        '';
      };

      # --- generations / rollback helpers ---

      nrl = {
        description = "List system generations";
        body = ''
          nix-env --list-generations --profile /nix/var/nix/profiles/system
        '';
      };

      nrr = {
        description = "Rollback to previous generation";
        body = ''
          sudo nixos-rebuild switch --rollback
        '';
      };

      # --- your git commit helper (keep as function; it has logic) ---

      gc = {
        description = "git commit -a -m ... (requires a message)";
        body = ''
          if test (count $argv) -eq 0
            echo 'Usage: gc "commit message"'
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

