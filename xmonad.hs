import XMonad
import XMonad.Util.EZConfig

main = xmonad $ def 
  { terminal    = "alacritty"
  , modMask     = mod4Mask
  , borderWidth = 1
  }
  `additionalKeys`
  [ ((mod4Mask, xK_p), spawn "ulauncher-toggle")
  , ((mod4Mask, xK_u), spawn "dm-tool switch-to-greeter")
  , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
  , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
  , ((0, xK_F1), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ((0, xK_F2), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
  , ((0, xK_F3), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
  ]
