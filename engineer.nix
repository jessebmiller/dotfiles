{ config, pkgs, sharedPassword, ... }: {
  users.users.engineer = {
    isNormalUser = true;
    description = "Jesse B. Miller (engineer)";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = sharedPassword;
  };

  home-manager.users.engineer = {pkgs, ... }: {
	  home.packages = with pkgs; [
		  brave
		  spotify
		  go
		  rustc
		  cargo
		  rustfmt
		  rust-analyzer
		  gcc
		  pkg-config
		  pnpm
		  nodejs
		  alsa-lib
	  ];

    programs.zsh.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/admin/dotfiles#laptop";
      edit-config = "nvim /home/admin/dotfiles/engineer.nix";
    };
	
	  home.stateVersion = "24.11";
  };
}
