# justMonika-wsl

## 端末名

JustMonika(Windows 11 Host)

## 型番

none

## Setup

### 1. OS(1stStep)

1. [NixOS WSL 公式ドキュメント](https://nix-community.github.io/NixOS-WSL/install.html)に従ってセットアップ
  - PostInstall まで終わらせる
2. `/etc/nixos/configuration.nix` の `wsl.defaultUser`, `nix.settings.experimental-features`, `networking.hostName` を変更,追記
3. `programs.git.enable` も有効化
4. `sudo nixos-rebuild switch`
5. Powershell から `wsl --shutdown` を叩いて強制シャットダウン
  - `sudo reboot` とかをやると Windows からの連携が死ぬことがあるらしい

### 2. OS(2ndStep: use repository flake)

1. `git clone https://github.com/huequica/nixDotFiles .nixDotFiles`
2. `nix develop`
3. `nh os switch .`

### 3. Home

1. `nix develop`
2. `nh home switch .`
