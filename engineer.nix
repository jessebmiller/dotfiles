{ config, pkgs, sharedPassword, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.engineer = {
    isNormalUser = true;
    description = "Jesse B. Miller (engineer)";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = sharedPassword;
  };

  home-manager.users.engineer = {pkgs, ... }: {
	  home.packages = with pkgs; [
		  brave
		  spotify
		  go
		  rustc
		  cargo
		  rustfmt
		  rust-analyzer
		  gcc
		  pkg-config
		  pnpm
		  nodejs_23
		  alsa-lib
	  ];
	
	home.stateVersion = "24.11";
  };
}
