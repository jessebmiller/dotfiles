import XMonad
import XMonad.Util.EZConfig

main = xmonad $ def 
  { terminal    = "/run/current-system/sw/bin/alacritty"
  , modMask     = mod4Mask
  , borderWidth = 1
  }
  `additionalKeys`
  [ ((mod4444Mask, xK_p), spawn "rofi -show run")
  ]
