{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    description = "Jesse B. Miller (admin)";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.admin = {pkgs, ... }: {
	  nixpkgs.config.allowUnfree = true;
	  home.packages = with pkgs; [
		  brave
		  neovim
		  spotify
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
	  programs.alacritty.settings = {
	      # copy themes from github.com/alacritty/alacritty-theme
	      general.import = [ ./solarized_osaka.toml ];
		  
	  };
	  home.stateVersion = "24.11";
  };
}
