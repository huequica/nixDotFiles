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
    firewall.enable = false;
  };

  services.expressvpn.enable = true;
  environment.systemPackages = with pkgs; [
    expressvpn
  ];
}
