{ config, pkgs, sharedPassword, ... }: {

  services.xserver.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = builtins.readFile ./xmonad.hs;
  };

  users.users.jesse = {
    isNormalUser = true;
    description = "Jesse B. Miller";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = sharedPassword;
  };

  home-manager.users.jesse = {pkgs, ... }: {
    home.packages = with pkgs; [
      brave
      spotify
      discord
    ];
	
    home.stateVersion = "24.11";
  };
}
