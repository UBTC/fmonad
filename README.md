This is my xmonad configuration, which is used with xfce4 applications.


|                 Key Binding       | Action                                                                           |
|:----------------------------------|:---------------------------------------------------------------------------------|
| W - Tab                           | cycling the windows                                                              |
| WS - Tab                          | cycling the windows the other direction                                          |
| W - q                             | swap the window up                                                               |
| WS - q                            | swap the window down                                                             |
| W - w                             | go to the next workspace                                                         |
| WS - w                            | go to the next workspace carring the current window                              |
| W - Escape                        | make the window to the correct size                                              |
| WS - Escape                       | sink all the windows                                                             |
| W - p                             | float the focused window                                                         |
| WS - p                            | restore the focused window                                                       |
| WS - b                            | copy the focused window to all workspace                                         |
| W - b                             | kill the other copies                                                            |
| WS - v                            | minimize the focused window                                                      |
| W - v                             | restore the minimized window                                                     |
| W - a                             | run, or raise, the window with given class name                                  |
| WS - a                            | swap the current window with the master, or swap the master with the next window |
| W - s                             | run or raise the terminals                                                       |
| W - d                             | run or raise the nvim editor running in stterm                                   |
| W - f                             | run or raise filemanagers                                                        |
| W - g                             | run or raise browsers                                                            |
| WS - s                            | run terminal                                                                     |
| WS - d                            | run nvim in stterm                                                               |
| WS - f                            | run fileManager                                                                  |
| WS - g                            | run browser                                                                      |
| W - z                             | run a command                                                                    |
| WS - z                            | run an application from the GUI launcher                                         |
| W - x                             | swap a window to master, and then go to it                                       |
| WS - x                            | return to the most recent window                                                 |
| W - c                             | run an xmonad command                                                            |
| WS - c                            | kill the focused window                                                          |
| W - i                             | decrease the volume                                                              |
| WS - i                            | increase volume                                                                  |
| W - o                             | decrease bright                                                                  |
| WS - o                            | increase bright                                                                  |
| W - space                         | switch to the next layout                                                        |
| W - semicolon                     | move the mouse pointer to the focused window                                     |
| W - slash                         | changing the current work dir.                                                   |
| WS - slash                        | open a given dir in filemanager                                                  |
| W - grave                         | focus the master window                                                          |
| WS - grave                        | swap the focused window to master                                                |
| WS - directions                   | float the current window and move it                                             |
| WC -directions                    | float the current window and increase its size                                   |
| WA -directions                    | float the current window and decrease its size                                   |
| W - e                             | increase the number of windows in main area (tile mode)                          |
| WS - e                            | decrease the number of windows in main area (tile mode)                          |
| W - r                             | increase the size of the main area (tile mode)                                   |
| WS - r                            | decrease the size of the main area (tile mode)                                   |
| W - t                             | increase the size of the current slave window (tile mode)                        |
| WS - t                            | decrease the size of the current slave window (tile mode)                        |
| W - u                             | refect the windows x directions (tile mode)                                      |
| WS - u                            | refect the windows y directions (tile mode)                                      |
| W - y                             | change the tile direction (tile mode)                                            |
| WS - y                            | restore the tile direction (tile mode)                                           |
| W - h                             | focus the window in the left directions (tile mode)                              |
| W - j                             | focus the window in the down directions (tile mode)                              |
| W - k                             | focus the window in the up directions (tile mode)                                |
| W - l                             | focus the window in the right directions (tile mode)                             |
| WS - h                            | swap the focused window to the left directions (tile mode)                       |
| WS - j                            | swap the focused window to the down directions (tile mode)                       |
| WS - k                            | swap the focused window to the up directions (tile mode)                         |
| WS - l                            | swap the focused window to the right directions (tile mode)                      |
| W - n                             | toggle the title bar                                                             |
| WS - n                            | toggle the panel                                                                 |
| W - m                             | increase the number of windows that can be seen in the current workspace         |
| WS - m                            | decrease the number of windows that can be seen in the current workspace         |
| W - comma                         | go to workspace 0                                                                |
| W - period                        | go to workspace 1                                                                |
| WS - comma                        | send the window to workspace 0                                                   |
| WS - period                       | send the window to workspace 1                                                   |
| W - 1..9                          | choose the (i+1)-th window, press grave for the first window                     |
| WC - 1..9                         | devide screens to left and right two panes                                       |
| WA - 1..9                         | devide screens to up and down two panes                                          |
| WC - 0                            | leave only one pane per WS                                                       |
| WA - 0                            | leave only one pane per WS                                                       |
| W - 0                             | run screensaver                                                                  |
| WCS - Escape                      | LOGOUT                                                                           |
| W - Left_mouse_button             | move window                                                                      |
| W - Middle_mouse_button           | sink all windows, and swap the clicked window to master                          |
| W - Right_mouse_button            | resize window                                                                    |
