{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.engineer = {
    isNormalUser = true;
    description = "Jesse B. Miller (engineer)";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.engineer = {pkgs, ... }: {
	  nixpkgs.config.allowUnfree = true;
	  home.packages = with pkgs; [
		  brave
		  neovim
		  spotify
		  go
		  pnpm
		  nodejs_23
	  ];
	  programs.zsh.enable = true;
	  programs.git = {
		  enable = true;
		  userName = "Jesse B. Miller";
		  userEmail = "jesse@jessebmiller.com";
		  extraConfig = {
			  init.defaultBranch = "main";
		  };
	  };
	  home.stateVersion = "24.11";
  };
}
