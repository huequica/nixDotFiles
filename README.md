# nixDotFiles

わたしの環境ファイル

![image](https://github.com/user-attachments/assets/e66df000-506d-420f-9515-a126e515898f)

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
    - **ここからの 2 ~ 9 は新規環境追加のみ実施**
2. `nix shell nixpkgs#vim` なりで vim を下ろしてくる
3. `mkdir -p hosts/${hostname} && cd hosts/${hostname}`
4. `cp /etc/nixos/* ./`
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

# darwin(macOS) 環境

[#32](https://github.com/huequica/nixDotFiles/pull/32) から darwin 環境もサポートしはじめた
初期セットアップの場合は以下の手順を踏む

1. Nix をインストールする
  - https://github.com/NixOS/nix-installer に従う
  - インストール時に Flake を有効化できるので必ず有効化
2. huequica/nixDotFiles を下ろしてくる
3. `sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .`
4. 以降は OS の設定, homebrew の設定の適用の際は `brew update && darwin-rebuild switch --flake .`
5. home-manager の設定に変更を入れた際は `nix develop && nh home switch .`
  - direnv を有効化していれば `nix develop` は省略可能

## MEMO

- nixpkgs 経由で入れた GUI アプリケーションは Spotlight から見つけられない
  - Raycast を入れてある そいつは発見可能
