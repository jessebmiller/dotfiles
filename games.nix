{ config, pkgs, sharedPassword, ... }: {

  users.users.games = {
    isNormalUser = true;
    description = "Jesse B. Miller (games)";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = sharedPassword;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = false;
  };

  home-manager.users.games = {pkgs, ... }: {
    home.packages = with pkgs; [
      brave
      spotify
      discord
    ];
	
    home.stateVersion = "24.11";
  };
}
