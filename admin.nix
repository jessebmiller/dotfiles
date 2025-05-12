{ config, pkgs, sharedPassword, ... }: {
 
  services.xserver.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = builtins.readFile ./xmonad.hs;
  };

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
