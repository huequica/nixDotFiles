# nixDotFiles

わたしの環境ファイル

## setup

### os

なんかいい感じに OS の設定するやつ

1. `nix develop`
2. `nh os switch .`
3. `reboot`

### home

home 以下のやつでいろいろするやつ

1. `nix develop`
2. `nh home switch .`

# NixOS をインストールしたらやること

## 1. `/etc/nixos/configuration.nix` をいじる

1. ホスト名の変更
2. experimental-features の追記
    - nix command と flake を有効化する 
3. programs.git.enable を true にする
4. `sudo nixos-rebuild switch && reboot`

## 2. 本格的な設定の同期

1. この repo を下ろしてくる
2. `nix shell nixpkgs#vim` なりで vim を下ろしてくる
3. `mkdir -p hosts/${hostname} && cd hosts/${hostname}`
4. `cp /etc/nixos/* ./`
    - **ここからの 5 ~ 9 は新規環境追加のみ実施**
5. 適宜 configuration.nix からデスクトップ定義などの余分な記述を消したりする
6. configuration.nix の `imports` に modules を追加
7. `mv configuration.nix nixos.nix`
8. `cp ../choco-nix/home-manager.nix ./`
    - 仕事用ソフトが必要な場合は `~/home-manager/works` も imports に入れる
9. `~/hosts/default.nix` に設定を追加
10. `nix develop`
11. `nh os switch .`
12. `nh home switch .`
13. `reboot`
