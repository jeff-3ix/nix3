# NixOS configuration (flake + home-manager)

This repo contains my NixOS configuration, managed with flakes and Home Manager.

## Branches

- **main**: Current modular configuration (hosts/, modules/, home/ layout).
- **legacy-pre-modular**: Archived pre-modular configuration (single-file style) kept for reference.

## Rebuild

```bash
sudo nixos-rebuild switch --flake ~/nixos-config#dell

