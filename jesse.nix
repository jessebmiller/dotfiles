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
      spotify
      discord
    ];
	
    home.stateVersion = "24.11";
  };
}
