import XMonad

main = xmonad def 
  { terminal    = "/run/current-system/sw/bin/xterm"
  , modMask     = mod4Mask
  , borderWidth = 1
  }
