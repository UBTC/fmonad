--------------------------------------------------------------------------------
-- https://github.com/travitch/taffybar/blob/master/taffybar.hs.example
--

import System.Taffybar
import System.Taffybar.Systray
import System.Taffybar.XMonadLog
import System.Taffybar.SimpleClock
import System.Taffybar.FreedesktopNotifications

main = do
  let clock = textClockNew Nothing "<span fgcolor='grey'>%y-%m-%d [%w] %H:%M:%S</span>" 1
      log = xmonadLogNew
      note = notifyAreaNew defaultNotificationConfig
      tray = systrayNew
      myTaffybarConfig = defaultTaffybarConfig
          { barHeight = 18
          , barPosition = Top
          , startWidgets = [ log, note ]
          , endWidgets = [ tray, clock ]
          }
  defaultTaffybar myTaffybarConfig
