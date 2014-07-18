import System.IO(hPutStrLn)
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers(doFullFloat,isFullscreen)
import XMonad.Layout.NoBorders(Ambiguity(OnlyFloat),smartBorders)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

myWorkspaceBar = "dzen2 -e '' -w '900' -ta 'l'"
myStatusBar = "$HOME/.xmonad/dzheader"
main = do
    workspaceBar <- spawnPipe myWorkspaceBar
    statusBar <- spawnPipe myStatusBar
    xmonad $ defaultConfig
      { logHook = myLogHook workspaceBar
      , layoutHook  = smartBorders $ avoidStruts $ layoutHook defaultConfig
      , manageHook = isFullscreen --> doFullFloat
      }
      `additionalKeys`
      [ ((mod1Mask, xK_b), sendMessage ToggleStruts) ]

myLogHook h = dynamicLogWithPP $ defaultPP
    { ppCurrent         = dzenColor "#303030" "#909090" . pad
    , ppHidden          = dzenColor "#909090" "" . pad
    , ppHiddenNoWindows = dzenColor "#606060" "" . pad
    , ppLayout          = dzenColor "#909090" "" . pad
    , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip
    , ppTitle           = shorten 100
    , ppWsSep           = ""
    , ppSep             = "  "
    , ppOutput          = hPutStrLn h
    }
