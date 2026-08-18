# Disk layout for the LUKS2-encrypted reinstall of huequica-m.
#
# NOTE: this file is intentionally NOT imported by ./nixos.nix yet. Importing
# it would make `disko.nixosModules.disko` derive `fileSystems` /
# `boot.initrd.luks.devices` from `disko.devices` below, which points at a
# LUKS mapper device that doesn't exist on the currently-running (unencrypted)
# disk. Wire this in (add `inputs.disko.nixosModules.disko` + `./disko.nix` to
# huequica-m's modules in ../default.nix) only from the NixOS installer
# environment, as part of the actual reinstall.
#
# Usage from the installer:
#   nix run github:nix-community/disko -- --mode disko ./disko.nix
# (omit `settings.keyFile`/`passwordFile` below to be prompted for the LUKS
# passphrase interactively instead of reading it from a file)
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-KIOXIA-EXCERIA_PLUS_G3_SSD_2GRKS0YCZ4KA";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                # allowDiscards trades a small amount of information leakage
                # (free-space layout is visible to an attacker with physical
                # disk access) for SSD TRIM support / longevity.
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
