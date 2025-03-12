{ config, pkgs, sharedPassword, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    description = "Jesse B. Miller (admin)";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = sharedPassword;
  };

  home-manager.users.admin = {pkgs, ... }: {
      home.packages = with pkgs; [
        brave
        spotify
      ];
	
    home.stateVersion = "24.11";
  };
}
