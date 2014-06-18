import XMonad
import XMonad.Hooks.ManageDocks    -- myLayoutHook
import XMonad.Util.Run(spawnPipe)  -- spawnPipe

myStatusBar = "$HOME/.xmonad/dzheader"
main = do
    statusBar <- spawnPipe myStatusBar
    xmonad $ defaultConfig
      { layoutHook  = avoidStruts $ layoutHook defaultConfig
      }
