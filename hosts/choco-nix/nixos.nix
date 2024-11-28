{
  inputs,
  config,
  pkgs,
  username,
  ...
}:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/core
      ../../modules/vm
      ../../modules/desktop
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-gpu-intel
      common-pc-ssd
    ]);

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  programs.fish.enable = true;
  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "docker"
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # DONT TOUCH THIS
  system.stateVersion = "24.05";
}
