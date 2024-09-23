# nixDotFiles

わたしの環境ファイル

## setup

### os

なんかいい感じに OS の設定するやつ

1. `nix develop`
2. `nh os switch .`
3. `reboot`

初回は `sudo nixos-rebuild switch --flake .#${hostName}` しないといけないかも

### home

home 以下のやつでいろいろするやつ

1. `nix develop`
2. `nh home switch .`
