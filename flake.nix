{

  description = "The computer systems of Jesse B. Miller";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      lib = nixpkgs.lib;
      sharedPassword = "$6$oUx6PfReu6GTwf1X$MqtG3kUBNZGWlJJO.4eDO1SOTHz1sdKVPztx4ppokxN2ydWSissxXSrSbgvgB9R72UCkP1e4QUIrkKubwrtpS.";

    in {
    nixosConfigurations = {
      # one configuration per host name
      # select which configuration to use for this 
      # machine by setting the hostname in ./configuration.nix
      # to match one of the below
      laptop = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
          ./configuration.nix
	  ./common.nix
	  home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	    _module.args.sharedPassword = sharedPassword;
          }
	];
      };
    };
  };

}
