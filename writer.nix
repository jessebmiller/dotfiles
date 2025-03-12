{ config, pkgs, sharedPassword, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
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

    home.stateVersion = "24.11";
  };
}
