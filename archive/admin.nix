{ config, pkgs, sharedPassword, ... }: {
 
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

    programs.zsh.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/admin/dotfiles#laptop";
      edit-config = "nvim /home/admin/dotfiles/admin.nix";
    };
	
    home.stateVersion = "24.11";
  };
}
