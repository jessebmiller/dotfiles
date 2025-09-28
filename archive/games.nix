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

    programs.zsh.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/admin/dotfiles#laptop";
      edit-config = "nvim /home/admin/dotfiles/games.nix";
    };
	
    home.stateVersion = "24.11";
  };
}
