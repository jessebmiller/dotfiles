import XMonad

main = xmonad def 
  { terminal    = "/run/current-system/sw/bin/alacritty"
  , modMask     = mod4Mask
  , borderWidth = 1
  }
