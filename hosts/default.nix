inputs:
let
  makeNixosSystem =
    {
      system,
      hostname,
      username,
      modules,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs hostname username;
      };
      modules = [
        ./cachix.nix
      ]
      ++ modules;
    };

  makeDarwinSystem =
    {
      hostname,
      username,
      modules,
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs hostname username;
      };
      modules = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
        ./cachix.nix
      ]
      ++ modules;
    };

  makeHomeManagerConfiguration =
    {
      system,
      username,
      overlays,
      modules,
      isWSL ? false,
    }:
    let
      homeDirectory =
        if inputs.nixpkgs.lib.hasSuffix "darwin" system then "/Users/${username}" else "/home/${username}";
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      extraSpecialArgs = {
        inherit inputs username isWSL;
        inherit (inputs) wdc buds-watcher;
      };

      modules = modules ++ [
        {
          home = {
            inherit username homeDirectory;
            stateVersion = "22.11";
          };
          programs.home-manager.enable = true;
        }
      ];
    };
in
{
  nixos = {
    choco-nix = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "choco-nix";
      username = "huequica";
      modules = [ ./choco-nix/nixos.nix ];
    };

    justYuri = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "justYuri";
      username = "huequica";
      modules = [ ./justYuri/nixos.nix ];
    };
    justMonika-wsl = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "justMonika-wsl";
      username = "huequica";
      modules = [
        inputs.nixos-wsl.nixosModules.default
        ./justMonika-wsl/nixos.nix
      ];
    };
    huequica-m = makeNixosSystem {
      system = "x86_64-linux";
      hostname = "huequica-m";
      username = "huequica";
      modules = [
        inputs.disko.nixosModules.disko
        ./huequica-m/nixos.nix
      ];
    };
  };

  darwin = {
    huequica-m-darwin = makeDarwinSystem {
      hostname = "huequica-m-darwin";
      username = "huequica";
      modules = [ ./huequica-m-darwin/darwin.nix ];
    };
  };

  home-manager = {
    "huequica@choco-nix" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [
        ./choco-nix/home-manager.nix
        inputs.mousehop.homeManagerModules.default
      ];
    };

    "huequica@justYuri" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [
        ./justYuri/home-manager.nix
        inputs.mousehop.homeManagerModules.default
      ];
    };

    "huequica@justMonika-wsl" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      isWSL = true;
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [
        ./justMonika-wsl/home-manager.nix
      ];
    };

    "huequica@huequica-m" = makeHomeManagerConfiguration {
      system = "x86_64-linux";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [
        ./huequica-m/home-manager.nix
        inputs.mousehop.homeManagerModules.default
      ];
    };

    "huequica@huequica-m-darwin" = makeHomeManagerConfiguration {
      system = "aarch64-darwin";
      username = "huequica";
      overlays = [
        inputs.fenix.overlays.default
        inputs.nix-claude-code.overlays.default
      ];
      modules = [
        ./huequica-m-darwin/home-manager.nix
        inputs.mousehop.homeManagerModules.default
      ];
    };
  };
}
