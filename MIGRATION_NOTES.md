# Migration notes (modularized branch)

1. Copy these files into the root of your repo (same level as flake.nix).

2. Move your existing `hardware-configuration.nix` to:
   - `hosts/dell/hardware-configuration.nix`

3. Rebuild:
   - `sudo nixos-rebuild switch --flake .#nixos`

4. (Optional) Once you confirm everything works, you can delete the old monolith files:
   - `configuration.nix`
   - `home.nix`
