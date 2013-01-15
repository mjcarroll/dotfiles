import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myTerminal = "/usr/bin/urxvt"

myWorkspaces= ["1"] ++ map show [2..8] ++ ["9:zim"]

myManageHook = composeAll
    [ className =? "Chromium"       --> doShift "1:web"
    , resource =? "desktop_window"  --> doIgnore
    , className =? "Google-chrome"  --> doShift "1:web"
    , className =? "firefox"        --> doShift "1:web"
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    tabbed shrinkText myTheme |||
    Full |||
    spiral (6/7) |||
    noBorders (fullscreenFull Full))

myFocusColor = "#60ff45"
textColor = "#c0c0a0"
lightTextColor = "#fffff0"
lightBackgroundColor = "#456030"
myUrgentColor = "#ffc000"
myNormalBorderColor = "#304520"
myFocusedBorderColor = "#60ff45"
myFont = "xft:DejaVu Sans:size=10"

myTheme = defaultTheme
    { activeColor = lightBackgroundColor
    , inactiveColor = myNormalBorderColor
    , urgentColor = lightBackgroundColor
    , activeBorderColor = textColor
    , inactiveTextColor = textColor
    , urgentTextColor = textColor
    , inactiveBorderColor = lightBackgroundColor
    , urgentBorderColor = myUrgentColor
    , activeTextColor = lightTextColor
    , fontName = myFont
    }

myBorderWidth = 1
myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  [ ((modMask .|. shiftMask, xK_Return),
    spawn $ XMonad.terminal conf)

  , ((modMask .|. controlMask, xK_l),
    spawn "leave")

  , ((modMask, xK_f),
    spawn "google-chrome")

  -- Launch dmenu
  , ((modMask, xK_a),
    spawn "exe=`dmenu_path` && eval \"exec $exe\"")

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  -- Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_Tab),
     windows W.focusDown)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap.
  -- TODO: update this binding with avoidStruts, ((modMask, xK_b),

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++
 
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

myStartupHook = return ()

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
  xmonad $ withUrgencyHook NoUrgencyHook $ defaults {
      logHook = dynamicLogWithPP $ xmobarPP 
        { ppCurrent = xmobarColor myFocusColor ""
        , ppVisible = xmobarColor lightTextColor ""
        , ppHiddenNoWindows = xmobarColor lightBackgroundColor ""
        , ppUrgent = xmobarColor myUrgentColor ""
        , ppSep = " · "
        , ppWsSep = ""
        , ppTitle = xmobarColor lightTextColor "" . shorten 100
        , ppOutput = hPutStrLn xmproc
        }
      , manageHook = manageDocks <+> myManageHook
      , startupHook = setWMName "LG3D"
  }
 

------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
    -- simple stuff
    terminal = myTerminal,
    focusFollowsMouse = myFocusFollowsMouse,
    borderWidth = myBorderWidth,
    modMask = myModMask,
    workspaces = myWorkspaces,
    normalBorderColor = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
 
    -- key bindings
    keys = myKeys,
    mouseBindings = myMouseBindings,
 
    -- hooks, layouts
    layoutHook = smartBorders $ myLayout,
    manageHook = myManageHook,
    startupHook = myStartupHook
}

