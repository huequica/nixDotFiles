# huequica-m-darwin

## 端末名

Apple Macbook Air

## 型番

none

## Setup

### 1. OS

1. MacOS のデスクトップ画面までまず到達させる
2. https://brew.sh で brew をインストール
3. https://github.com/NixOS/nix-installer にしたがって nix をインストール
   - 必ず flake を enable する
4. `git clone https://github.com/huequica/nixDotFiles .nixDotFiles`
5. `sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#huequica-m-darwin`

`darwin-version` を叩いて表示されれば問題なし  
以降の brew などのアップデートは `brew update && sudo darwin-rebuild switch --flake .` を使う

### 2. Home

1. `nix develop`
2. `nh home switch .`

以降は `direnv allow` をすれば develop shell に入る必要はない
