import XMonad
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Util.Run (spawnPipe)

myStatusBar = "$HOME/.xmonad/dzheader"
main = do
    statusBar <- spawnPipe myStatusBar
    xmonad $ defaultConfig
      { layoutHook  = avoidStruts $ layoutHook defaultConfig
      }
