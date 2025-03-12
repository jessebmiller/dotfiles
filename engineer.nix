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
		  pnpm
		  nodejs_23
	  ];
	
	home.stateVersion = "24.11";
  };
}
