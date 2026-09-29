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

  # Let the "input" group read/write the INZONE Buds receiver without
  # root, so buds-watcher can poll it directly.
  # (logind's uaccess ACL didn't take effect on this system, so use a
  # plain group instead.)
  # buds-watcher now uses the `hidapi` PyPI package, whose Linux backend
  # goes through libusb (not the hidraw kernel driver), so it needs
  # access to the raw /dev/bus/usb/* node, not /dev/hidraw*.
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ec2", MODE="0660", GROUP="input"

    # HDMI/DisplayPort の抜き差しで ALSA が発行する "change" イベントを捕まえて、
    # home-manager 側の hdmi-monitor-names.service (モニター名を ELD から
    # 読み直して wireplumber に反映する) を即座に起動する。
    ACTION=="change", SUBSYSTEM=="sound", KERNEL=="card0", TAG+="systemd", ENV{SYSTEMD_WANTS}+="hdmi-monitor-names-trigger.service"
  '';

  # udev はシステムの systemd からしかユニットを起動できないため、ユーザー
  # セッションの hdmi-monitor-names.service を起動するための橋渡し役。
  # スリープからの復帰時(モニター構成が変わりうる)にも同じ経路で呼ぶ。
  systemd.services.hdmi-monitor-names-trigger = {
    description = "Ask the user session to refresh HDMI monitor names in WirePlumber";
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.systemd}/bin/systemctl --user --machine="${username}@" --no-block restart hdmi-monitor-names.service || true
    '';
  };

  powerManagement.resumeCommands = ''
    ${pkgs.systemd}/bin/systemctl start hdmi-monitor-names-trigger.service
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
