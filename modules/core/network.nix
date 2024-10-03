{
  config,
  hostname,
  pkgs,
  ...
}:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  services.expressvpn.enable = true;
  environment.systemPackages = with pkgs; [
    expressvpn
  ];
}
