# Matto's Nix config

## Rebuild system configuration

```bash
sudo nixos-rebuild switch --flake .
```

## Rebuild user configuration

```bash
home-manager switch --flake .
```

## Update system
This will update the flake.lock packages versions

```bash
nix flake update
```

After updating the versions in the lock file, we have to apply them to both the system and the user configs:

```bash
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
```
## Utils

### Platformio with VSCodium

Using a very useful flake that makes it work with arduino boards and write firmware to them.

1. Go to your project repo
2. Enter the devshell:
   ```bash
   nix develop github:xdadrm/nixos_use_platformio_patformio-ide_and_vscode
   ```
3. `codium .`

Source: https://github.com/xdadrm/nixos_use_platformio_patformio-ide_and_vscode


