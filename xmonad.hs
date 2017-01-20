{-# LANGUAGE
     DeriveDataTypeable,
     FlexibleContexts,
     FlexibleInstances,
     MultiParamTypeClasses,
     NoMonomorphismRestriction,
     PatternGuards,
     ScopedTypeVariables,
     TypeSynonymInstances,
     UndecidableInstances
     #-}

--------------------------------------------------------------------------------
--
-- Yet Another Xmonad Configuration
--
-- Mogei Wang
-- COPYRIGHT 2009-2017
--
-- 2009 Dalian University of Technology
-- 2010 Dalian University of Technology
-- 2011 Dalian University of Technology
-- 2012 Ningbo University
-- 2013 Fenghua, Ningbo, Zhejiang
-- 2014 Dev. Zone, Dalian, Liaoning
-- 2015 Shanghai Jiao Tong University
-- 2016 Shanghai Jiao Tong University
--
--------------------------------------------------------------------------------

import XMonad hiding ((|||))
import XMonad.Config.Desktop
import XMonad.Actions.CycleWS
import XMonad.Actions.Warp
import XMonad.Actions.UpdatePointer
import XMonad.Actions.CopyWindow
import XMonad.Actions.Commands
import XMonad.Actions.FloatSnap
import XMonad.Actions.GroupNavigation
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowGo
import XMonad.Actions.WindowBringer
import XMonad.Actions.MouseResize
import XMonad.Actions.FloatKeys
import XMonad.Actions.FocusNth
import XMonad.Actions.Promote
import XMonad.Actions.DwmPromote
import XMonad.Actions.WithAll
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.RestoreMinimized
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceByPos
import XMonad.Layout
import XMonad.Layout.LayoutScreens
import XMonad.Layout.LimitWindows
import XMonad.Layout.TwoPane
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Reflect
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.DwmStyle
import XMonad.Layout.BoringWindows
import XMonad.Layout.Tabbed
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.WindowNavigation
import XMonad.Layout.WindowArranger
import XMonad.Layout.WindowSwitcherDecoration
import XMonad.Layout.Named
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Workspace
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import Data.Char
import Data.Monoid
import Data.Ratio ((%))
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86

------------------------------------------------------------------------
--
myBorderWidth = 1
colorBlack = "#00181f"
colorBlackAlt = "#005a74"
colorGray = "#444444"
colorGrayAlt = "#161616"
colorDarkGray = "#171717"
colorGolden = "#cfbfad"
colorWhite = "#a9a6af"
colorWhiteAlt = "#9d9d9d"
colorMagenta = "#8e82a2"
colorCyan = "#04c6c6"
colorBlue = "#0087cb"
colorOrange = "#ff7701"
colorPink = "#e3008d"
colorRed = "#d74b73"
colorGreen = "#99cc66"
colorYellow = "#b58900"
myNormalBorderColor = colorBlack
myFocusedBorderColor = colorGray
myModMask = mod4Mask
myFocusFollowsMouse = True
myWorkspaces = ["#0", "#1"]

myTerminal0 = "gnome-terminal"
myTerminal1 = "x-terminal-emulator"
myTerminal2 = "xfce4-terminal"
myTerminal3 = "lxterminal"
myTerminal4 = "roxterm"
myTerminal5 = "konsole"
myEditor0 = "emacs"
myEditor1 = "gvim"
myEditor2 = "kate"
myEditor3 = "yi"
myEditor4 = "geany"
myEditor5 = "emacs"
myFileManager0 = "nautilus"
myFileManager1 = "thunar"
myFileManager2 = "dolphin"
myFileManager3 = "pcmanfm"
myFileManager4 = "spacefm"
myFileManager5 = "file"
myBrowser0 = "firefox"
myBrowser1 = "x-www-browser"
myBrowser2 = "google-chrome"
myBrowser3 = "chromium"
myBrowser4 = "opera"
myBrowser5 = "tor Browser"

myGUILauncher = "gmrun" -- xfce4-appfinder  --disable-server"
myCLILauncher = "dmenu_run -i "
mySh = "fish"
myTermLauncher = mySh ++ " -c cat /dev/null | dmenu -i | xargs -i " ++ myTerminal0 ++ " -e {}"
myLocker = "slock"
myScreenshoter = "scrot -e 'mv $f ~/screenshots/'" -- xfce4-screenshooter
myVolumeDecrease = "amixer -D pulse sset Master 10%-"
myVolumeIncrease = "amixer -D pulse sset Master 5%+"
myVolumeMute = "amixer -D pulse sset Master 0"
myVolumeUnmute = "amixer -D pulse sset Master 30%"
myBrightDecrease = "xbacklight -10%"
myBrightIncrease = "xbacklight +5%"
myHeight = 18
myFont = "xft:WenQuanYi Zen Hei Mono:Bold:pixelsize=12:antialias=true:autohint=true"

myXPConfig = defaultXPConfig
    { font = myFont
    , height = myHeight
    , position = Top
    , promptBorderWidth = 0
    , bgColor = colorDarkGray
    , fgColor = colorGreen
    , bgHLight = colorGreen
    , fgHLight = colorDarkGray
    , historySize = 100
    , historyFilter = deleteConsecutive
    }

myCommands = defaultCommands
data EnterPrompt = EnterPrompt String
instance XPrompt EnterPrompt where showXPrompt (EnterPrompt n) = "Confirm : " ++ n ++ " ? Esc/Enter> "
confirmPrompt :: XPConfig -> String -> X() -> X()
confirmPrompt config app func = mkXPrompt (EnterPrompt app) config (mkComplFunFromList []) $ const func

------------------------------------------------------------------------
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Tab), windows W.focusDown)
    , ((modm .|. shiftMask, xK_Tab), windows W.focusUp)
    , ((modm, xK_grave), windows W.swapUp)
    , ((modm .|. shiftMask, xK_grave), windows W.swapDown)

    , ((modm, xK_a), runOrRaiseNext myBrowser0 (className =? myBrowser0 <||> className =? upperSHead myBrowser0 <||> className =? myBrowser1 <||> className =? upperSHead myBrowser1 <||> className =? myBrowser2 <||> className =? upperSHead myBrowser2 <||> className =? myBrowser3 <||> className =? upperSHead myBrowser3 <||> className =? myBrowser4 <||> className =? upperSHead myBrowser4 <||> className =? myBrowser5 <||> className =? upperSHead myBrowser5) )
    , ((modm, xK_s), runOrRaiseNext myTerminal0 (className =? (myTerminal0) <||> className =? upperSHead (myTerminal0) <||> className =? myTerminal1 <||> className =? upperSHead myTerminal1 <||> className =? myTerminal2 <||> className =? upperSHead myTerminal2 <||> className =? myTerminal3 <||> className =? upperSHead myTerminal3 <||> className =? myTerminal4 <||> className =? upperSHead myTerminal4 <||> className =? (myTerminal5) <||> className =? upperSHead (myTerminal5)) ) -- >> (windows $ W.swapMaster) >> (windows $ W.greedyView "#0")
    , ((modm, xK_d), runOrRaiseNext myEditor0 (className =? myEditor0 <||> className =? upperSHead myEditor0 <||> className =? myEditor1 <||> className =? upperSHead myEditor1 <||> className =? myEditor2 <||> className =? upperSHead myEditor2 <||> className =? myEditor3 <||> className =? upperSHead myEditor3 <||> className =? myEditor4 <||> className =? upperSHead myEditor4 <||> className =? myEditor5 <||> className =? upperSHead myEditor5) )
    , ((modm, xK_f), runOrRaiseNext myFileManager0 (className =? myFileManager0 <||> className =? upperSHead myFileManager0 <||> className =? myFileManager1 <||> className =? upperSHead myFileManager1 <||> className =? myFileManager2 <||> className =? upperSHead myFileManager2 <||> className =? myFileManager3 <||> className =? upperSHead myFileManager3 <||> className =? myFileManager4 <||> className =? upperSHead myFileManager4 <||> className =? myFileManager5 <||> className =? upperSHead myFileManager5) )
    , ((modm .|. shiftMask, xK_a), (spawn myBrowser0) )
    , ((modm .|. shiftMask, xK_s), (spawn myTerminal0) )
    , ((modm .|. shiftMask, xK_d), (spawn myEditor0) )
    , ((modm .|. shiftMask, xK_f), (spawn myFileManager0) )

    , ((0, xF86XK_DOS), runOrRaiseNext myTerminal0 (className =? (myTerminal0) <||> className =? upperSHead (myTerminal0) <||> className =? myTerminal1 <||> className =? upperSHead myTerminal1 <||> className =? myTerminal2 <||> className =? upperSHead myTerminal2 <||> className =? myTerminal3 <||> className =? upperSHead myTerminal3 <||> className =? myTerminal4 <||> className =? upperSHead myTerminal4 <||> className =? (myTerminal5) <||> className =? upperSHead (myTerminal5)) )
    , ((modm, xF86XK_Documents), runOrRaiseNext myEditor0 (className =? myEditor0 <||> className =? upperSHead myEditor0 <||> className =? myEditor1 <||> className =? upperSHead myEditor1 <||> className =? myEditor2 <||> className =? upperSHead myEditor2 <||> className =? myEditor3 <||> className =? upperSHead myEditor3 <||> className =? myEditor4 <||> className =? upperSHead myEditor4 <||> className =? myEditor5 <||> className =? upperSHead myEditor5) )
    , ((0, xF86XK_MyComputer), runOrRaiseNext myFileManager0 (className =? myFileManager0 <||> className =? upperSHead myFileManager0 <||> className =? myFileManager1 <||> className =? upperSHead myFileManager1 <||> className =? myFileManager2 <||> className =? upperSHead myFileManager2 <||> className =? myFileManager3 <||> className =? upperSHead myFileManager3 <||> className =? myFileManager4 <||> className =? upperSHead myFileManager4 <||> className =? myFileManager5 <||> className =? upperSHead myFileManager5) )
    , ((0, xF86XK_WWW), runOrRaiseNext myBrowser0 (className =? myBrowser0 <||> className =? upperSHead myBrowser0 <||> className =? myBrowser1 <||> className =? upperSHead myBrowser1 <||> className =? myBrowser2 <||> className =? upperSHead myBrowser2 <||> className =? myBrowser3 <||> className =? upperSHead myBrowser3 <||> className =? myBrowser4 <||> className =? upperSHead myBrowser4 <||> className =? myBrowser5 <||> className =? upperSHead myBrowser5) )
    , ((shiftMask, xF86XK_DOS), spawn myTerminal0)
    , ((shiftMask, xF86XK_Documents), spawn myEditor0)
    , ((shiftMask, xF86XK_MyComputer), spawn myFileManager0)
    , ((shiftMask, xF86XK_WWW), spawn myBrowser0)

    , ((modm, xK_x), spawn myCLILauncher)
    , ((modm .|. shiftMask, xK_x), spawn myGUILauncher)
    , ((modm, xK_c), myCommands >>= runCommand)
    , ((modm .|. shiftMask, xK_c), XMonad.kill)
    , ((modm, xK_v), spawn myVolumeDecrease)
    , ((modm .|. shiftMask, xK_v), spawn myVolumeIncrease)
    , ((modm, xK_b), spawn myBrightDecrease)
    , ((modm .|. shiftMask, xK_b), spawn myBrightIncrease)

    , ((0, xF86XK_ScreenSaver), spawn myLocker)
    , ((0, xF86XK_Eject), spawn "eject")
    , ((shiftMask, xF86XK_Eject), spawn "eject -t")
    , ((0, xF86XK_Search), spawn "catfish")
    , ((0, xF86XK_AudioLowerVolume), spawn myVolumeDecrease)
    , ((0, xF86XK_AudioRaiseVolume), spawn myVolumeIncrease)
    , ((0, xF86XK_AudioMute), spawn myVolumeMute)
    , ((shiftMask, xF86XK_AudioMute), spawn myVolumeUnmute)
    , ((0, xF86XK_MonBrightnessDown), spawn myBrightDecrease)
    , ((0, xF86XK_MonBrightnessUp), spawn myBrightIncrease)

    , ((modm, xK_e), sendMessage (IncMasterN 1))
    , ((modm .|. shiftMask, xK_e), sendMessage (IncMasterN(-1)))
    , ((modm, xK_w), nextWS)
    , ((modm .|. shiftMask, xK_w), shiftToNext >> nextWS)
    , ((modm, xK_t), sendMessage $ Toggle FULL)
    , ((modm .|. shiftMask, xK_t), sendMessage ToggleStruts)
    , ((modm, xK_r), increaseLimit)
    , ((modm .|. shiftMask, xK_r), decreaseLimit)

    , ((modm, xK_space), sendMessage NextLayout)
    , ((modm, xK_BackSpace), spawn myLocker)
    , ((modm, xK_period), gotoMenu >> windows W.swapMaster)
    , ((modm, xK_comma), nextMatch History (return True))
    , ((modm .|. controlMask, xK_0), rescreen)
    , ((modm .|. mod1Mask, xK_0), rescreen)
    , ((0, xK_Print), spawn myScreenshoter)
    , ((modm .|. controlMask .|. shiftMask, xK_Escape), confirmPrompt myXPConfig "LOGOUT" $ io (exitWith ExitSuccess)) -- xK_Caps_Lock
    , ((0, xF86XK_Sleep), spawn ("gksudo pm-suspend"))
    , ((shiftMask, xF86XK_Sleep), spawn ("gksudo pm-hibernate"))
    ] ++ [
    ((modm, k), focusNth i) | (i, k) <- zip [0 .. 9] ([xK_1 .. xK_9]++[xK_0])
    ] ++ [
--  ((modm .|. shiftMask, k), swapNth i) | (i, k) <- zip [0 .. 9] ([xK_1 .. xK_9]++[xK_0])
    ] ++ [
    ((modm .|. mod1Mask, k), layoutScreens 2 (Mirror (TwoPane (i/10) (1-i/10)))) | (i, k) <- zip [1 .. 9] [xK_1 .. xK_9]
    ] ++ [
    ((modm .|. controlMask, k), layoutScreens 2 (TwoPane (i/10) (1-i/10))) | (i, k) <- zip [1 .. 9] [xK_1 .. xK_9]
    ] where upperSHead s = [toTitle $ head s] ++ drop 1 s

------------------------------------------------------------------------
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> XMonad.mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> sinkAll >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> XMonad.mouseResizeWindow w >> windows W.shiftMaster))
    ]

------------------------------------------------------------------------
--
myLayout = mouseResize $ windowArrange $ windowNavigation $ boringWindows $ desktopLayoutModifiers $ avoidStruts
         $ mkToggle (NOBORDERS ?? FULL ?? EOT)
         $ smartBorders (named " Tab " myFull ||| named " Tile " myTile)
         where
         myFull = limitWindows 6 $ fullDeco $ minimize $ maximize $ workspaceDir "~" (tabbedAlways shrinkText myFullTheme)
         myTile = limitWindows 4 $ tileDeco $ minimize $ maximize
                     $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ mkToggle (single MIRROR)
                     $ workspaceDir "~" mouseResizableTile { masterFrac = 0.5, fracIncrement = 0.1, isMirrored = False }
         fullDeco l = dwmStyle shrinkText myFullTheme l
         tileDeco l = windowSwitcherDecoration shrinkText myTileTheme l
         myFullTheme = defaultTheme
             { fontName = myFont
             , decoHeight = myHeight
             , inactiveBorderColor = colorBlackAlt
             , inactiveColor       = colorBlack
             , inactiveTextColor   = colorGolden
             , activeBorderColor   = colorGray
             , activeColor         = colorBlackAlt
             , activeTextColor     = colorGolden
             , urgentBorderColor   = colorRed
             , urgentTextColor     = colorGreen
             }
         myTileTheme = myFullTheme

------------------------------------------------------------------------
--
myManageHook = composeAll . concat $
    [ [ manageDocks
      , workspaceByPos
      , isFullscreen --> doFullFloat
      , isDialog --> doCenterFloat
      , (resource =? "desktop_window") --> doIgnore
      , (resource =? "kdesktop") --> doIgnore
      , (resource =? "xfdesktop") --> doIgnore
      , (resource =? "dialog") --> doFloat
      , (resource =? "xfce4-panel") --> doFloat
      , (resource  =? "gcr-prompter") --> doCenterFloat
      , (title =? "hangouts") --> doFloat
      , (title =? "GMChess") --> doCenterFloat
      , (stringProperty "WM_WINDOW_ROLE" =? "pop-up") --> doFloat
      , (stringProperty "WM_WINDOW_ROLE" =? "preferences") --> doFloat
      ]
    , [ (className =? cf) --> doCenterFloat | cf <- centerFloat]
    , [ (className =? sf) --> doFloat | sf <- simpleFloat]
--  , [ (className =? e) --> doShift "#0" | e <- editor]
--  , [ (className =? r) --> doShift "#0" | r <- reader]
--  , [ (className =? t) --> doShift "#0" | t <- terminal]
--  , [ (className =? f) --> doShift "#1" | f <- filemanager]
--  , [ (className =? b) --> doShift "#1" | b <- browser]
--  , [ (className =? p) --> doShift "#1" | p <- play]
    ] where
    simpleFloat = ["gtk-recordMyDesktop", "MPlayer", "gimp", "skype"]
    centerFloat = ["Xfce4-appfinder", "Xfrun4", "feh", "wrapper", "xmessage", "synaptic", "taffybar-linux-x86_64"]
--  browser = ["Firefox", "Midori", "Chromium Browser", "google-chrome", "Opera", "X-www-browser", "Tor Browser"]
--  editor = ["Gvim", "Emacs24", "Kate", "Gedit", "Geany", "Emacs", "Atom", "Neovim",  "Yi-linux-x86_64"]
--  filemanager = ["Spacefm", "Thunar", "Pcmanfm", "Nautilus", "Dolphin", "File"]
--  play = ["Rhythmbox","Gwibber", "Empathy", "Pidgin", "SuperTuxKart"] ++ simpleFloat
--  reader = ["Zathura", "Okular", "Evince", "mupdf", "xpdf"]
--  terminal = ["stterm-256color", "xterm", "Roxterm", "X-terminal-emulator", "Xfce4-terminal", "Lxterminal", "Gnome-terminal", "Konsole"]

------------------------------------------------------------------------
--
myEventHook = do
    ewmhDesktopsEventHook
    restoreMinimizedEventHook
    fullscreenEventHook
    handleEventHook desktopConfig

-------------------------------------------------------------------------
--
myLogHook = do
    updatePointer (0.5, 0.5) (1, 1)
    takeTopFocus >> setWMName "LG3D"
    logHook desktopConfig
    ewmhDesktopsLogHook

------------------------------------------------------------------------
--
myStartupHook = do
    ewmhDesktopsStartup
    startupHook desktopConfig
    spawnOnce "setxkbmap -option caps:swapescape" -- swap caps and esc
--  spawnOnce "xmodmap -e 'pointer = 1 2 3 5 4 7 6 8 9 10 11 12'" -- mouse...
--  spawnOnce "xrandr --output eDP1 --right-of DP2 --auto" -- two screens
    spawnOnce "nm-applet" -- network monitor
    spawnOnce "fcitx-autostart" -- input Chinese
    spawnOnce "xbacklight = 20" -- screen brightness
    spawnOnce "xfce4-power-manager" -- power manager
    spawnOnce "xsetroot -solid black -cursor_name left_ptr" -- desktop background & mouse pointer
    spawnOnce "pactl set-sink-volume 0 '10%'" -- volume
    spawnOnce "xfce4-panel" -- the panel
    spawnOnce "skype" -- keep in touch
    -- spawnOnce "megasync" -- cloud storage
    spawnOnce "xautolock -time 5 -locker slock -nowlocker slock" -- autolocker
    spawnOnce "mpv /home/mw/MEGAsync/Music/login-sound/ubuntu11/desktop-login.ogg" -- login sound
    spawnOnce "mkdir -p ~/screenshots/"
--  spawn eamcs as daemon???

------------------------------------------------------------------------
-- Now run Xmonad with all the configurations we set up.
------------------------------------------------------------------------
main = do
    xmonad $ ewmh desktopConfig
        { terminal = "stterm"
        , focusFollowsMouse = myFocusFollowsMouse
        , borderWidth = myBorderWidth
        , modMask = myModMask
        , workspaces = myWorkspaces
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , keys = myKeys
        , mouseBindings = myMouseBindings
        , layoutHook = myLayout
        , manageHook = myManageHook
        , handleEventHook = myEventHook
        , logHook = myLogHook >> historyHook
        , startupHook = myStartupHook
        }