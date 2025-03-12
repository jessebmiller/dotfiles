{ config, pkgs, ... }: {
  home-manager.sharedModules = [{
    programs.git = {
      enable = true;
      userName = "Jesse B. Miller";
      userEmail = "jesse@jessebmiller.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 11;
        font.normal.family = "Inconsolata";
        general.import = [ ./solarized_dark.toml ];
      };
    };
    
    programs.zsh.enable = true;
    programs.tmux.enable = true;
    programs.neovim.enable = true;
    programs.starship.enable = true;
  }];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrains Mono Nerd Font" ];
    sansSerif = [ "Montserrat" ];
    serif = [ "EB Garamond" ];
  };
}
