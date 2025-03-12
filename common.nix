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
        font.normal.family = "Martian Mono";
        general.import = [ ./solarized_dark.toml ];
      };
    };

    programs.zsh = {
      enable = true;
      initExtra = ''
        eval "$(starship init zsh)"
      '';
    };
    programs.tmux.enable = true;
    programs.neovim.enable = true;
    programs.starship.enable = true;
  }];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Martian Mono" ];
    sansSerif = [ "Nunito" ];
    serif = [ "EB Garamond" ];
  };
}
