{ config, pkgs, sharedPassword, ... }: {
  users.users.writer = {
    isNormalUser = true;
    description = "Jesse B. Miller";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = sharedPassword;
  };

  home-manager.users.writer = {pkgs, ... }: {
    home.packages = with pkgs; [
      spotify
    ];

    programs.neovim = {
      enable = true;
    
      extraConfig = ''
        " Writer-specific neovim config
        set spell
        set wrap
        set linebreak
      '';
    
      plugins = with pkgs.vimPlugins; [
        goyo-vim
        limelight-vim
      ];
    };

    programs.zsh.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/admin/dotfiles#laptop";
      edit-config = "nvim -c 'set nospell' -c 'set nowrap' /home/admin/dotfiles/writer.nix";
    };

    home.stateVersion = "24.11";
  };
}
