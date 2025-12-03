{
  description = "My first flake";

  inputs = {
    #     vicinae.url = "github:vicinaehq/vicinae"; # here I am adding the vicinae package because it's not available
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
     home-manager.url = "github:nix-community/home-manager/release-25.05";
     home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    #vicinae, # enable that extra package in the output
    ...
    }: 
	let 
	  lib = nixpkgs.lib;
	  homeLib = home-manager.lib;
	  system = "x86_64-linux";
	  pkgs = nixpkgs.legacyPackages.${system};

	in {
	  nixosConfigurations = {
		sahitya-nixos = lib.nixosSystem { # it's actually a function which takes some nix-expressions and build the system using those expressions
		  # system = "x86_64-linux";
		  inherit system;
		  modules = [
		  ./configuration.nix
		  ];
		};
	  };

# 	This setup is for standalone installation

          homeConfigurations = {
		sahitya-nixos-user = homeLib.homeManagerConfiguration { # it's actually a function which takes some nix-expressions and build the system using those expressions
		inherit pkgs;
		  modules = [
            ./home.nix 
            #       vicinae.homeManagerModules.default
          ];
		};
	  };
	};
}
