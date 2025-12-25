# NixOS configuration (flake + home-manager)

This repo contains my NixOS configuration, managed with flakes and Home Manager.

## Branches

- **main**: Current modular configuration (hosts/, modules/, home/ layout).
- **legacy-pre-modular**: Archived pre-modular configuration (single-file style) kept for reference.

## Rebuild

```bash
sudo nixos-rebuild switch --flake ~/nixos-config#dell
```

## Git "doctor" checklist (when something feels off)

### 1. **Am I on the right branch?**

```bash
git branch -vv
```
- main = current modular configuration
- legacy-pre-modular = archived pre-modular configuration

### 2. **Is my branch tracking the correct remote?**

``` bash
git status
git branch -vv
```

You should see ```[origin/main]``` on ```main```.

If missing:
```bash
git push --set-upstream origin main
```

### 3. **What flake am I actually rebuilding?**

```bash
nix flake show ~/nixos-config
```

Expected output includes:
```nixosConfigurations.dell```

Canonical rebuild command:
```bash
sudo nixos-rebuild switch --flake ~/nixos-config#dell
```

### 4. **Why am I being prompted for GitHub credentials (or why not)?**

Git is managed declaratively via NixOS + Home Manager.
- Git package: `gitFull` (not plain `git`)
- Credential helper: `libsecret` (GNOME keyring)
Relevant config locations:
- `modules/nixos/environment.nix` --> Git + credential helper
- `modules/home/git.nix` --> Git behavior (push defaults, etc.)
Check which helper Git is using:
```bash
git config --get credential.helper
```
If prompts suddenly reappear, the keyring may not be unlocked (common with auto-login).

### 5. ** Why is `~/.config/git/config` read-only?**

Because Home Manager owns it.
Do *not* use:
```bash
git config --global ...
```
Fix Git behavior declaratively in:
`~/nixos-config/modules/home/git.nix`

### 6. **Are new branches auto-tracking the remote?**

This is enabled declaratively via Home Manager:
```nix
push.autoSetupRemote = true;
```
New branches should automatically track `origin/<branch>` on first push.

### 7. **Where is the last known-good pre-modular configuration?**

Preserved for reference:
- Branch: `legacy-pre-modular`
- Tag: `pre-modular-final`

```bash
git show pre-modular-final
```

### 8. **Minimal "panic dump" (when nothing makes sense)**

```bash
git status
git branch -vv
git log --oneline --decorate -5
```


