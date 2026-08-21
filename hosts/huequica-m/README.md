# huequica-m

## 端末名

Thinkpad X13 gen7

## 型番

`21YHCTO1WW`

## Setup

### 1. OS

1. nixOS の LiveUSB を起動
2. ネットワーク接続
3. `nix-shell -p git --run 'git clone https://github.com/huequica/nixDotFiles /tmp/nixDotFiles'`
4. SSD が disko.nix に指定されているものと一致するか確認
   - `lsblk -o NAME, SIZE, MODEL, SERIAL`
   - `ls -la /dev/disk/by-id/ | grep KIOXIA`
   - ここで一致しないと disko によるディスクのセットアップがコケる
5. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko /tmp/nixDotFiles/hosts/huequica-m/disko.nix`
   - LUKS のディスク暗号化をするのでパスフレーズ登録を同時に行う
   - 正常に完了していれば `/boot`, `/home`, `/nix` がマウントされている
6. `sudo nixos-generate-config --no-fileystems` でハードウェア情報を生成
   - ファイルシステムは disko が管理するためハードウェア情報から omit
7. `/etc/nixos/hardware-configuration.nix` を `hosts/huequica-m/hardware-configuration.nix` としてコピー
8. `sudo nixos-install --flake .#huequica-m`

この際 clone した repository は当然ながら SSD に入らない  
変更を入れている場合は再度ローカルに clone して変更し直す必要あり

### 2. Home

1. `git clone https://github.com/huequica/nixDotFiles .nixDotFiles`
2. `nix develop`
3. `nh home switch .`

以降は `direnv allow` をすれば develop shell に入る必要はない

### 3. TPM2 enroll

TPM2 モジュールに鍵を任せることで起動の度に LUKS のパスフレーズを打たなくても sddm のログイン画面まで到達する  
(この画面が LUKS のパスフレーズ認証を兼任している)

`sudo systemd-cryptenroll --tpm2-device=auto /dev/disk/by-id/nvme-KIOXIA-EXCERIA_PLUS_G3_SSD_2GRKS0YCZ4KA-part2`
