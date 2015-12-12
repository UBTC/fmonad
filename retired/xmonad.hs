--------------------------------------------------------------------------------
--
-- Yet Another Xmonad Configuration
--
-- Mogei Wang
-- COPYRIGHT 2009-2015
--
-- 2009 Dalian University of Technology
-- 2010 Dalian University of Technology
-- 2011 Dalian University of Technology
-- 2012 Ningbo University
-- 2013 Fenghua, Ningbo, Zhejiang
-- 2014 Dev. Zone, Dalian, Liaoning
-- 2015 Shanghai Jiao Tong University
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
import XMonad.Actions.WithAll
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.RestoreMinimized
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceByPos
import XMonad.Layout.LayoutScreens
import XMonad.Layout.LimitWindows
import XMonad.Layout.TwoPane
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Reflect
import XMonad.Layout.WorkspaceDir
import XMonad.Layout
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
import XMonad.Util.SpawnOnce
import Data.Char
import Data.Monoid
import Data.Ratio ((%))
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Taffybar.XMonadLog
import DBus.Client

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
myTerminal0 = "konsole"
myTerminal1 = "x-terminal-emulator"
myTerminal2 = "xfce4-terminal"
myTerminal3 = "lxterminal"
myTerminal4 = "gnome-terminal"
myTerminal5 = "stterm"
myEditor0 = "emacs24"
myEditor1 = "gvim"
myEditor2 = "kate"
myEditor3 = "gedit"
myEditor4 = "geany"
myReader0 = "zathura"
myReader1 = "okular"
myReader2 = "evince"
myReader3 = "mupdf"
myReader4 = "xpdf"
myFileManager0 = "dolphin"
myFileManager1 = "thunar"
myFileManager2 = "pcmanfm"
myFileManager3 = "nautilus"
myFileManager4 = "spacefm"
myBrowser0 = "google-chrome"
myBrowser1 = "x-www-browser"
myBrowser2 = "firefox"
myBrowser3 = "chromium"
myBrowser4 = "opera"
myBrowser5 = "tor Browser"
myGUILauncher = "gmrun"
myCLILauncher = "dmenu_run -i "
mySh = "fish"
myTermLauncher = mySh ++ " -c cat /dev/null | dmenu -i | xargs -i " ++ myTerminal0 ++ " -e {}"
myLocker = "slock"
myScreenshoter = "ksnapshot"
myVolumeDecrease = "amixer -D pulse sset Master 10%-"
myVolumeIncrease = "amixer -D pulse sset Master 5%+"
myBrightDecrease = "xbacklight -10%"
myBrightIncrease = "xbacklight +5%"
myHeight = 18
myFont = "xft:WenQuanYi Zen Hei Mono:Bold:antialias=true:pixelsize=12"
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
myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navHandler
  where navKeyMap = M.fromList
          [ ((0,xK_Escape), cancel)
          , ((0,xK_Return), select)
          , ((0,xK_slash) , substringSearch myNavigation)
          , ((0,xK_Left)  , move (-1,0)  >> myNavigation)
          , ((0,xK_h)     , move (-1,0)  >> myNavigation)
          , ((0,xK_Right) , move (1,0)   >> myNavigation)
          , ((0,xK_l)     , move (1,0)   >> myNavigation)
          , ((0,xK_Down)  , move (0,1)   >> myNavigation)
          , ((0,xK_j)     , move (0,1)   >> myNavigation)
          , ((0,xK_Up)    , move (0,-1)  >> myNavigation)
          , ((0,xK_k)     , move (0,-1)  >> myNavigation)
          , ((0,xK_space) , setPos (0,0) >> myNavigation)
          , ((0, xK_Tab)  , move (0,1)   >> myNavigation)
          , ((0, xK_grave), move (0,-1)  >> myNavigation)
          ]
        navHandler = const myNavigation
myGSconfig = defaultGSConfig
    { gs_cellheight = 26
    , gs_cellwidth = 1000
    , gs_font = myFont
    , gs_navigate = myNavigation
    }
myCommands = defaultCommands

------------------------------------------------------------------------
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Tab), windows W.focusDown)
    , ((modm .|. shiftMask, xK_Tab), windows W.focusUp)
    , ((modm, xK_q), nextMatch History (return True))
    , ((modm .|. shiftMask, xK_q), windows W.swapUp)
    , ((modm, xK_Escape), goToSelected myGSconfig)

    , ((modm, xK_a), nextWS)
    , ((modm .|. shiftMask, xK_a), shiftToNext >> nextWS)

    , ((modm, xK_s), runOrRaiseNext myTerminal0 (className =? (myTerminal0) <||> className =? upperSHead (myTerminal0) <||> className =? myTerminal1 <||> className =? upperSHead myTerminal1 <||> className =? myTerminal2 <||> className =? upperSHead myTerminal2 <||> className =? myTerminal3 <||> className =? upperSHead myTerminal3 <||> className =? myTerminal4 <||> className =? upperSHead myTerminal4 <||> className =? (myTerminal5++"-256color") <||> className =? upperSHead (myTerminal5++"-256color")) >> (windows $ W.greedyView "#0"))
    , ((modm, xK_d), runOrRaiseNext myEditor0 (className =? myEditor0 <||> className =? upperSHead myEditor0 <||> className =? myEditor1 <||> className =? upperSHead myEditor1 <||> className =? myEditor2 <||> className =? upperSHead myEditor2 <||> className =? myEditor3 <||> className =? upperSHead myEditor3 <||> className =? myEditor4 <||> className =? upperSHead myEditor4) >> (windows $ W.greedyView "#0"))
    , ((modm, xK_f), runOrRaiseNext myFileManager0 (className =? myFileManager0 <||> className =? upperSHead myFileManager0 <||> className =? myFileManager1 <||> className =? upperSHead myFileManager1 <||> className =? myFileManager2 <||> className =? upperSHead myFileManager2 <||> className =? myFileManager3 <||> className =? upperSHead myFileManager3 <||> className =? myFileManager4 <||> className =? upperSHead myFileManager4) >> (windows $ W.greedyView "#1"))
    , ((modm, xK_g), runOrRaiseNext myBrowser0 (className =? myBrowser0 <||> className =? upperSHead myBrowser0 <||> className =? myBrowser1 <||> className =? upperSHead myBrowser1 <||> className =? myBrowser2 <||> className =? upperSHead myBrowser2 <||> className =? myBrowser3 <||> className =? upperSHead myBrowser3 <||> className =? myBrowser4 <||> className =? upperSHead myBrowser4 <||> className =? myBrowser5 <||> className =? upperSHead myBrowser5) >> (windows $ W.greedyView "#1"))
    , ((modm .|. shiftMask, xK_s), (spawn myTerminal0) >> (windows $ W.greedyView "#0"))
    , ((modm .|. shiftMask, xK_d), (spawn myEditor0) >> (windows $ W.greedyView "#0"))
    , ((modm .|. shiftMask, xK_f), (spawn myFileManager0) >> (windows $ W.greedyView "#1"))
    , ((modm .|. shiftMask, xK_g), (spawn myBrowser0) >> (windows $ W.greedyView "#1"))

    , ((modm, xK_z), gotoMenu >> windows W.swapMaster)
    , ((modm .|. shiftMask, xK_z), windows W.swapUp >> windows W.focusDown)
    , ((modm, xK_x), spawn myCLILauncher)
    , ((modm .|. shiftMask, xK_x), spawn myTermLauncher)
    , ((modm, xK_c), myCommands >>= runCommand)
--    , ((modm, xK_c), spawn myGUILauncher)
    , ((modm .|. shiftMask, xK_c), XMonad.kill)
    , ((modm, xK_v), spawn myVolumeDecrease)
    , ((modm .|. shiftMask, xK_v), spawn myVolumeIncrease)
    , ((modm, xK_b), spawn myBrightDecrease)
    , ((modm .|. shiftMask, xK_b), spawn myBrightIncrease)

    , ((modm, xK_space), sendMessage NextLayout)
    , ((modm, xK_p), warpToWindow (0.5) (0.5))
    , ((modm, xK_semicolon), refresh)
    , ((modm, xK_slash), changeDir myXPConfig)
    , ((modm .|. shiftMask, xK_slash), AL.launchApp myXPConfig { defaultText = "~" } myFileManager0)
    , ((modm, xK_grave), windows W.focusMaster)
    , ((modm .|. shiftMask, xK_grave), windows W.swapMaster)

    , ((modm, xK_Left),  withFocused $ snapMove L Nothing)
    , ((modm, xK_Right), withFocused $ snapMove R Nothing)
    , ((modm, xK_Up),    withFocused $ snapMove U Nothing)
    , ((modm, xK_Down),  withFocused $ snapMove D Nothing)
    , ((modm .|. controlMask, xK_Left),  withFocused (keysResizeWindow (-150, 0) (0,0)))
    , ((modm .|. controlMask, xK_Right), withFocused (keysResizeWindow (150, 0) (0,0)))
    , ((modm .|. controlMask, xK_Down),  withFocused (keysResizeWindow (0, 100) (0,0)))
    , ((modm .|. controlMask, xK_Up),    withFocused (keysResizeWindow (0,-100) (0,0)))
    , ((modm .|. shiftMask, xK_Left),  withFocused (keysResizeWindow (150, 0) (1,1)))
    , ((modm .|. shiftMask, xK_Right), withFocused (keysResizeWindow (-150, 0) (1,1)))
    , ((modm .|. shiftMask, xK_Up),    withFocused (keysResizeWindow (0, 100) (1,1)))
    , ((modm .|. shiftMask, xK_Down),  withFocused (keysResizeWindow (0,-100) (1,1)))

    , ((modm, xK_w), withFocused $ float >> keysMoveWindowTo (175, 100) (0, 0))
    , ((modm .|. shiftMask, xK_w), withFocused $ windows . W.sink)
    , ((modm, xK_e), withAll $ float >> keysMoveWindowTo (175, 100) (0, 0))
    , ((modm .|. shiftMask, xK_e), sinkAll)
    , ((modm, xK_o), windows copyToAll)
    , ((modm .|. shiftMask, xK_o), killAllOtherCopies)

    , ((modm, xK_t), sendMessage Expand)
    , ((modm .|. shiftMask, xK_t), sendMessage Shrink)
    , ((modm, xK_y), sendMessage ExpandSlave)
    , ((modm .|. shiftMask, xK_y), sendMessage ShrinkSlave)
    , ((modm, xK_r), sendMessage (IncMasterN 1))
    , ((modm .|. shiftMask, xK_r), sendMessage (IncMasterN(-1)))
    , ((modm, xK_u), sendMessage $ Toggle REFLECTX)
    , ((modm .|. shiftMask, xK_u), sendMessage $ Toggle REFLECTY)
    , ((modm, xK_i), sendMessage $ Toggle MIRROR)
    , ((modm .|. shiftMask, xK_i), sendMessage $ Toggle MIRROR)

    , ((modm, xK_h), sendMessage $ Go L)
    , ((modm, xK_j), sendMessage $ Go D)
    , ((modm, xK_k), sendMessage $ Go U)
    , ((modm, xK_l), sendMessage $ Go R)
    , ((modm .|. shiftMask, xK_h), sendMessage $ Swap L)
    , ((modm .|. shiftMask, xK_j), sendMessage $ Swap D)
    , ((modm .|. shiftMask, xK_k), sendMessage $ Swap U)
    , ((modm .|. shiftMask, xK_l), sendMessage $ Swap R)

    , ((modm, xK_n), sendMessage $ Toggle FULL)
    , ((modm .|. shiftMask, xK_n), sendMessage ToggleStruts)
    , ((modm, xK_m), increaseLimit)
    , ((modm .|. shiftMask, xK_m), decreaseLimit)
    , ((modm .|. shiftMask, xK_0), rescreen)
    , ((modm .|. controlMask, xK_0), rescreen)
    , ((modm, xK_0), spawn myScreenshoter)
    , ((modm, xK_minus), spawn myLocker)

    , ((modm .|. controlMask .|. shiftMask, xK_Caps_Lock), io (exitWith ExitSuccess))
    ] ++ [
    ((m .|. modm .|. controlMask, key), screenWorkspace sc >>= flip whenJust (windows . f)) | (key, sc) <- zip [xK_comma, xK_period] [0, 1]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ] ++ [
    ((m .|. modm, key), windows $ f i) | (i, key) <- zip (XMonad.workspaces conf) ([xK_comma, xK_period])
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] ++ [
    ((modm, k), focusNth i) | (i, k) <- zip [1 .. 9] [xK_1 .. xK_9] -- xK_i (1..9) choose the (i+1)-th window, press grave for the first window
    ] ++ [ -- WS-xK_i/WC-xK_i twoPanes treated as in two separate screens.
    ((modm .|. shiftMask, k), layoutScreens 2 (Mirror (TwoPane (i/10) (1-i/10)))) | (i, k) <- zip [1 .. 9] [xK_1 .. xK_9]
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
         myFull = limitWindows 6 $ fullDeco $ minimize $ maximize $ workspaceDir "~" (tabbedAlways shrinkText myTabTheme)
         myTile = limitWindows 4 $ tileDeco $ minimize $ maximize
                     $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ mkToggle (single MIRROR)
                     $ workspaceDir "~" mouseResizableTile { masterFrac = 0.5, fracIncrement = 0.1, isMirrored = False }
         fullDeco l = dwmStyle shrinkText myTabTheme l
         tileDeco l = windowSwitcherDecoration shrinkText myTileTheme l
         myTabTheme = defaultTheme
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
         myTileTheme = myTabTheme

------------------------------------------------------------------------
--
myManageHook = composeAll . concat $
    [ [ manageDocks
      , workspaceByPos
      , isFullscreen --> doFullFloat
      , isDialog --> doCenterFloat
      , (resource =? "desktop_window") --> doIgnore
      , (resource =? "desktop_window") --> doIgnore
      , (resource =? "kdesktop") --> doIgnore
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
    , [ (className =? e) --> doShift "#0" | e <- editor]
    , [ (className =? r) --> doShift "#0" | r <- reader]
    , [ (className =? t) --> doShift "#0" | t <- terminal]
    , [ (className =? f) --> doShift "#1" | f <- filemanager]
    , [ (className =? b) --> doShift "#1" | b <- browser]
    , [ (className =? p) --> doShift "#1" | p <- play]
    ] where
    simpleFloat = ["gtk-recordMyDesktop", "MPlayer", "gimp", "skype"]
    centerFloat = ["Xfce4-appfinder", "Xfrun4", "feh", "wrapper", "xmessage", "synaptic", "taffybar-linux-x86_64"]
    browser = ["Firefox","Midori","Chromium Browser","Chrome","Google-chrome", "Opera", "X-www-browser", "Tor Browser"]
    editor = ["Gvim", "Emacs24", "Kate", "Gedit", "Geany"]
    filemanager = ["Spacefm", "Thunar", "Pcmanfm", "Nautilus", "Dolphin", "File"]
    play = ["Rhythmbox","Gwibber", "Empathy", "Pidgin", "SuperTuxKart"] ++ simpleFloat
    reader = ["Zathura", "Okular", "Evince", "mupdf", "xpdf"]
    terminal = ["stterm-256color", "xterm", "Roxterm", "X-terminal-emulator", "Xfce4-terminal", "Lxterminal", "Gnome-terminal", "Konsole"]

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
    updatePointer (Relative 0.5 0.5)
    takeTopFocus >> setWMName "LG3D"
    logHook desktopConfig
    ewmhDesktopsLogHook

------------------------------------------------------------------------
--
myStartupHook = do
    ewmhDesktopsStartup
    startupHook desktopConfig
    spawnOnce "xrandr --output eDP1 --right-of DP2 --auto"
    spawnOnce "nm-applet" -- network monitor
    spawnOnce "fcitx-autostart" -- input Chinese
    spawnOnce "xbacklight = 20" -- screen brightness
    spawnOnce "xfce4-power-manager" -- power manager
    spawnOnce "xsetroot -solid black -cursor_name left_ptr" -- desktop background & mouse pointer
    spawnOnce "pactl set-sink-volume 0 '10%'" -- volume
    spawnOnce "taffybar" -- the panel
    spawnOnce "keynav" -- keyboard-driven mouse cursor mover
    spawnOnce "dropbox start" -- cloud storage
    spawnOnce "/opt/copy/CopyAgent" -- cloud storage
    spawnOnce "xautolock -time 5 -locker slock -nowlocker slock" -- autolocker

------------------------------------------------------------------------
--
myTaffybarPP = defaultPP
    { ppCurrent = taffybarColor "black" "yellow" . wrap " " " "
    , ppVisible = taffybarColor "yellow" "gray" . wrap " " " "
    , ppHidden = taffybarColor "white" "" . wrap " " " "
    , ppHiddenNoWindows = taffybarColor "gray" "" . const " 〇 "
    , ppUrgent = taffybarColor "red" "yellow" . wrap " "  " "
    , ppTitle = wrap "<b>" "</b>" . taffybarEscape . shorten 60
    , ppSep = "   .   "
    , ppWsSep = "   "
    , ppLayout = wrap "<b>" "</b>"
    } where
    wrap l r m = l ++ m ++ r
    shorten n xs | length xs < n = xs | otherwise = take n xs ++ "..."

------------------------------------------------------------------------
-- Now run Xmonad with all the configurations we set up.
------------------------------------------------------------------------
--
main = do
    client <- connectSession
    xmonad $ ewmh desktopConfig
        { terminal = myTerminal0
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
        , logHook = myLogHook >> dbusLogWithPP client myTaffybarPP >> historyHook
        , startupHook = myStartupHook
        }
