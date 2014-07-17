import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers(doFullFloat,isFullscreen)
import XMonad.Layout.NoBorders(Ambiguity(OnlyFloat),smartBorders)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

myStatusBar = "$HOME/.xmonad/dzheader"
main = do
    statusBar <- spawnPipe myStatusBar
    xmonad $ defaultConfig
      { layoutHook  = smartBorders $ avoidStruts $ layoutHook defaultConfig
      , manageHook = isFullscreen --> doFullFloat
      }
      `additionalKeys`
      [ ((mod1Mask, xK_b), sendMessage ToggleStruts) ]
