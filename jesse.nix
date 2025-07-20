{ config, pkgs, sharedPassword, ... }: {

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

    programs.zsh.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/admin/dotfiles#laptop";
      edit-config = "nvim /home/admin/dotfiles/jesse.nix";
    };
	
    home.stateVersion = "24.11";
  };
}
