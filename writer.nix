{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jesse = {
    isNormalUser = true;
    description = "Jesse B. Miller";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.steam = {
	enable = true;
	remotePlay.openFirewall = false;
	dedicatedServer.openFirewall = false;
	localNetworkGameTransfers.openFirewall = false;
  };

  home-manager.users.jesse = {pkgs, ... }: {
	  nixpkgs.config.allowUnfree = true;
	  home.packages = with pkgs; [
		  brave
		  neovim
		  spotify
                  discord
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
	  programs.alacritty = {
		enable = true;
		settings = {
			font.size = 11;
			general.import = [ ./solarized_dark.toml ];
		};
	  };
	  home.stateVersion = "24.11";
  };
}
