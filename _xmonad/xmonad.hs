import XMonad hiding (Tall)
 
import XMonad.Actions.Promote
import XMonad.Actions.UpdatePointer
import XMonad.Actions.Warp

import qualified XMonad.Actions.Search as S
import XMonad.Actions.Search
import qualified XMonad.Actions.Submap as SM

import XMonad.Util.Scratchpad 

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus

import XMonad.Layout.LayoutHints
import XMonad.Layout.HintedTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh

import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.NamedWindows

import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace

import qualified XMonad.StackSet as W
 
import qualified Data.Map as M
import Data.Ratio
import System.IO (hPutStrLn)
import GHC.IOBase (Handle)

main :: IO ()
main = do
    xmobar <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
        { normalBorderColor  = backgroundColor
        , focusedBorderColor = focusColor
        , focusFollowsMouse = False
        , terminal = "urxvt"
        , layoutHook = myLayout
        , workspaces = myWorkspaces
        , manageHook = manageDocks <+> myManageHook
        , modMask = mod4Mask
        , borderWidth = 1
        , keys = \c -> myKeys c `M.union` keys defaultConfig c
        , logHook = dynamicLogWithPP (myPP xmobar) <+> takeTopFocus
        , startupHook = setWMName "LG3D"
        }
        where
            genericLayout = layoutHints $ avoidStruts $ smartBorders $ hintedTile Tall
                                 ||| hintedTile Wide
                                 ||| Full
                                 ||| tabbed shrinkText myTheme
                                 ||| spiral (1 % 1)
            hintedTile = HintedTile nmaster delta ratio TopLeft
            nmaster = 1
            ratio   = 1/2
            delta   = 3/100

            myLayout = genericLayout

            myWorkspaces = map show [1..9]

            myManageHook = composeAll
                [   className =? "psi" --> doShift "9"
                  , className =? "Hamster-time-tracker" --> doShift "9"
                  , className =? "Rviz" --> doShift "4"
                  , appName =? "tasklist" --> doShift "9"
                ] <+> manageScratchPad
                where
                    doShiftAndGo ws = doF (W.greedyView ws) <+> doShift ws
 
            manageScratchPad :: ManageHook
            manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
                where
                    h = 0.1
                    w = 1
                    t = 1 - h
                    l = 1 - w

            myPP :: Handle -> PP
            myPP din = defaultPP
                { ppCurrent = xmobarColor focusColor ""
                , ppVisible = xmobarColor lightTextColor ""
                , ppHidden = noScratchPad
                , ppHiddenNoWindows = xmobarColor lightBackgroundColor ""
                , ppUrgent = xmobarColor urgentColor ""
                , ppSep = " · "
                , ppWsSep = ""
                , ppTitle = xmobarColor lightTextColor ""
                , ppOutput = hPutStrLn din
                }
                where
                    noScratchPad ws = if ws == "NSP" then "" else ws
 
            myTheme :: Theme
            myTheme = defaultTheme
                { activeColor = lightBackgroundColor
                , inactiveColor = backgroundColor
                , urgentColor = backgroundColor
                , activeBorderColor = textColor
                , inactiveTextColor = textColor
                , urgentTextColor = textColor
                , inactiveBorderColor = lightBackgroundColor
                , urgentBorderColor = urgentColor
                , activeTextColor = lightTextColor
                , fontName = myFont
                }
 
            myXPConfig :: XPConfig
            myXPConfig = defaultXPConfig
                { font        = myFont
                , bgColor     = backgroundColor
                , fgColor     = textColor
                , fgHLight    = lightTextColor
                , bgHLight    = lightBackgroundColor
                , borderColor = lightBackgroundColor
                }
 
            myFont = "xft:Ubuntu Mono:size=14"

            searchEngineMap method = M.fromList $
                [ ((0, xK_g), method S.google )
                , ((0, xK_y), method S.youtube )
                , ((0, xK_m), method S.maps )
                , ((0, xK_d), method S.dictionary )
                , ((0, xK_w), method S.wikipedia )
                ]
 
            focusColor = "#60ff45"
            textColor = "#c0c0a0"
            lightTextColor = "#fffff0"
            backgroundColor = "#304520"
            lightBackgroundColor = "#456030"
            urgentColor = "#ffc000"
 
            myKeys conf@(XConfig {XMonad.modMask = modMask, workspaces = ws}) = M.fromList $
                [ ((modMask,                 xK_b), sendMessage ToggleStruts)
                , ((modMask,                 xK_f), spawn "firefox")
                , ((modMask ,                xK_s ),SM.submap $ searchEngineMap $ S.promptSearchBrowser myXPConfig "firefox")
                , ((modMask .|. controlMask, xK_x), shellPrompt myXPConfig)
                , ((modMask .|. controlMask, xK_s), sshPrompt myXPConfig)
                , ((modMask,                 xK_z), warpToWindow 1 1)
                , ((modMask,                 xK_q), recompile True >> restart "xmonad" True)
                , ((modMask .|. controlMask, xK_l), spawn "slock")
                , ((modMask,                 xK_y), spawn "hamster-time-tracker")
                ]
