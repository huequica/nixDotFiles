{
  hostname,
  username,
  ...
}:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  # nix そのものは別途インストーラーで導入済みのため nix-darwin による管理は無効化する
  nix.enable = false;

  networking.hostName = hostname;
  networking.computerName = hostname;

  system.primaryUser = username;
  users.users.${username}.home = "/Users/${username}";

  # fish を login shell にしているため、/etc/fish/config.fish を生成して
  # /run/current-system/sw/bin などの nix-darwin の PATH を fish にも通す
  programs.fish.enable = true;

  homebrew = {
    enable = true;
    # home-manager 側 (home-manager/gui) で darwin 未対応の nixpkgs パッケージを cask で代替する
    casks = [
      "vlc"
      "vivaldi"
    ];
  };

  # DONT TOUCH THIS
  system.stateVersion = 7;
}
