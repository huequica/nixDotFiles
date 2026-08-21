# justYuri

## 端末名

HP Pavilion Aero Laptop 13-be

## 型番

`6E1T7PA`

## Setup

### 1. OS

1. nixOS の LiveUSB を起動
2. ネットワーク接続
3. `nix-shell -p git --run 'git clone https://github.com/huequica/nixDotFiles /tmp/nixDotFiles'`
4. `sudo nixos-generate-config` でハードウェア情報を生成
5. `/etc/nixos/hardware-configuration.nix` を `hosts/justYuri/hardware-configuration.nix` としてコピー
6. `sudo nixos-install --flake .#justYuri`

この際 clone した repository は当然ながら SSD に入らない

### 2. Home

1. `git clone https://github.com/huequica/nixDotFiles .nixDotFiles`
2. `nix develop`
3. `nh home switch .`

以降は `direnv allow` をすれば develop shell に入る必要はない
