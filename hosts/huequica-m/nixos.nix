{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/core
    ../../modules/desktop
    ../../modules/bluetooth
    ../../modules/fingerprint
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.fish.enable = true;
  users.users."${username}" = {
    # NOTE: claude use bash, so keep bash as default shell.
    # shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # DONT TOUCH THIS
  system.stateVersion = "26.05"; # Did you read the comment?
}
