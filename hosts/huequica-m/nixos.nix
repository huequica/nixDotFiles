{
  username,
  pkgs,
  ...
}:

{
  imports = [
    ./disko.nix

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

  # usbmon: for capturing USB traffic (e.g. reverse-engineering the INZONE
  # Buds USB receiver protocol) via `sudo modprobe usbmon` + tshark.
  boot.kernelModules = [ "usbmon" ];
  environment.systemPackages = [
    pkgs.wireshark-cli # provides tshark
    pkgs.usbutils # provides lsusb
  ];

  # Let the "input" group read/write the INZONE Buds receiver's hidraw
  # device without root, so buds-watcher can poll it directly.
  # (logind's uaccess ACL didn't take effect on this system, so use a
  # plain group instead.)
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ec2", MODE="0660", GROUP="input"
  '';

  programs.fish.enable = true;
  users.users."${username}" = {
    # NOTE: claude use bash, so keep bash as default shell.
    # shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # DONT TOUCH THIS
  system.stateVersion = "26.05";
}
