{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jesse = {
    isNormalUser = true;
    description = "Jesse B. Miller";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.jesse = {pkgs, ... }: {
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
