{ config, hostname, ...}:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
}
