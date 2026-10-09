# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  username,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/core
  ];

  wsl = {
    enable = true;
    defaultUser = "huequica";
    ssh-agent.enable = true;
  };

  # WSL has no real network interfaces to manage and no wifi hardware;
  networking.networkmanager.enable = lib.mkForce false;

  programs.fish.enable = true;
  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  # DONT TOUCH THIS
  system.stateVersion = "26.05";
}
