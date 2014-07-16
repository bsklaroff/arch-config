import XMonad
import XMonad.Hooks.ManageDocks(avoidStruts)
import XMonad.Hooks.ManageHelpers(doFullFloat,isFullscreen)
import XMonad.Layout.NoBorders(Ambiguity(OnlyFloat),lessBorders)
import XMonad.Util.Run(spawnPipe)

myStatusBar = "$HOME/.xmonad/dzheader"
main = do
    statusBar <- spawnPipe myStatusBar
    xmonad $ defaultConfig
      { layoutHook  = lessBorders OnlyFloat $ avoidStruts $ layoutHook defaultConfig
      , manageHook = isFullscreen --> doFullFloat
      }
