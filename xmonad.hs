import XMonad
import XMonad.Util.EZConfig

main = xmonad $ def 
  { terminal    = "alacritty"
  , modMask     = mod4Mask
  , borderWidth = 1
  }
  `additionalKeys`
  [ ((mod4Mask, xK_p), spawn "ulauncher-toggle")
    ((mod4Mask, xK_u), spawn "dm-tool switch-to-greeter")
  ]
