# MONADIC

This is my xmonad configuration. The core of this configuration is mature and handy, and has been heavily used for years.

[The `\retired` is my previous configuration for using xmonad with taffybar.]

## Installation

1. Install the required applications:

    `xmonad, xfce4-desktop, firefox`, and [suckless-tools](http://tools.suckless.org), [neovim](https://neovim.io/), [fish](http://fishshell.com/).

2. Backup the previous configurations:

    `mv ~/.xmonad ~/.xmonad.backup`

3. Clone this configuration:

    `git clone 'https://github.com/mogeiwang/fmonad' ~/.xmonad`

4. Recompile xmonad:

    `xmonad --recompile`

5. Restart xmonad:

    `xmonad --restart`

6. That's all, have fun!

## Basic features and usage

- There are 2 workspaces. Editors and terminals are put in the 1st workspace by default, and file manager and web browser are put in the 2nd workspace by default.

Use the following key bindings to switch between workspaces `(W-Windows, S-shift, A-Alt, C-Ctrl)`:

```
    W - comma   : go to workspace 0
    W - period  : go to workspace 1
    WS - comma  : send the window to workspace 0
    WS - period : send the window to workspace 1
```

- There are 2 layouts modes, i.e., `tab` and `tile`. In the `tab` mode, 1 window frame, and 5 other window titles, can be observed. In the `tile` mode, 4 window frames can be observed by default. The number of window that can be observed can be changed by `W-M` (add) and `W-S-M` (minus).

To change the layout mode: `W - space : switch to the next layout`

- Two panes can be engaged in both layout modes, with each pane being the view of a workspace:

```
    WC - 1..9 : devide screens to (left and right) two panes
    WA - 1..9 : devide screens to (up and down) two panes
    WC - 0    : leave only one pane per WS
    WA - 0    : leave only one pane per WS
```

- The whole layout can be reflect in different directions in the tile mode:

```
    W - u  : refect the windows x directions
    WS - u : refect the windows y directions
    W - y  : change the tile direction (turn 90 degrees)
    WS - y : restore the tile direction
```

- Run command and kill application with `W-z` and `WS-c`:

```
    W - z  : run a command
    WS - z : run an application from the GUI launcher
    W - c  : run an xmonad command
    WS - c : kill the focused window
```

- You can put some windows on both workspaces (`W - Tab : cycling the windows`), and try to use the following key bindings.

## Key Bindings

|         Key Binding       | Action                                                                           |
|:--------------------------|:---------------------------------------------------------------------------------|
| W - Tab                   | cycling the windows                                                              |
| WS - Tab                  | cycling the windows the other direction                                          |
| W - q                     | swap the window up                                                               |
| WS - q                    | swap the window down                                                             |
| W - w                     | go to the next workspace                                                         |
| WS - w                    | go to the next workspace carring the current window                              |
| W - Escape                | make the window to the correct size                                              |
| WS - Escape               | sink all the windows                                                             |
| W - p                     | float the focused window                                                         |
| WS - p                    | restore the focused window                                                       |
| WS - b                    | copy the focused window to all workspace                                         |
| W - b                     | kill the other copies                                                            |
| WS - v                    | minimize the focused window                                                      |
| W - v                     | restore the minimized window                                                     |
| W - a                     | run, or raise, the window with given class name                                  |
| WS - a                    | swap the current window with the master, or swap the master with the next window |
| W - s                     | run or raise the terminals                                                       |
| W - d                     | run or raise the nvim editor running in stterm                                   |
| W - f                     | run or raise filemanagers                                                        |
| W - g                     | run or raise browsers                                                            |
| WS - s                    | run terminal                                                                     |
| WS - d                    | run nvim in stterm                                                               |
| WS - f                    | run fileManager                                                                  |
| WS - g                    | run browser                                                                      |
| W - z                     | run a command                                                                    |
| WS - z                    | run an application from the GUI launcher                                         |
| W - x                     | swap a window to master, and then go to it                                       |
| WS - x                    | return to the most recent window                                                 |
| W - c                     | run an xmonad command                                                            |
| WS - c                    | kill the focused window                                                          |
| W - i                     | decrease the volume                                                              |
| WS - i                    | increase volume                                                                  |
| W - o                     | decrease bright                                                                  |
| WS - o                    | increase bright                                                                  |
| W - space                 | switch to the next layout                                                        |
| W - semicolon             | move the mouse pointer to the focused window                                     |
| W - slash                 | changing the current work dir.                                                   |
| WS - slash                | open a given dir in filemanager                                                  |
| W - grave                 | focus the master window                                                          |
| WS - grave                | swap the focused window to master                                                |
| WS - directions           | float the current window and move it                                             |
| WC -directions            | float the current window and increase its size                                   |
| WA -directions            | float the current window and decrease its size                                   |
| W - e                     | increase the number of windows in main area (tile mode)                          |
| WS - e                    | decrease the number of windows in main area (tile mode)                          |
| W - r                     | increase the size of the main area (tile mode)                                   |
| WS - r                    | decrease the size of the main area (tile mode)                                   |
| W - t                     | increase the size of the current slave window (tile mode)                        |
| WS - t                    | decrease the size of the current slave window (tile mode)                        |
| W - u                     | refect the windows x directions (tile mode)                                      |
| WS - u                    | refect the windows y directions (tile mode)                                      |
| W - y                     | change the tile direction (tile mode)                                            |
| WS - y                    | restore the tile direction (tile mode)                                           |
| W - h                     | focus the window in the left directions (tile mode)                              |
| W - j                     | focus the window in the down directions (tile mode)                              |
| W - k                     | focus the window in the up directions (tile mode)                                |
| W - l                     | focus the window in the right directions (tile mode)                             |
| WS - h                    | swap the focused window to the left directions (tile mode)                       |
| WS - j                    | swap the focused window to the down directions (tile mode)                       |
| WS - k                    | swap the focused window to the up directions (tile mode)                         |
| WS - l                    | swap the focused window to the right directions (tile mode)                      |
| W - n                     | toggle the title bar                                                             |
| WS - n                    | toggle the panel                                                                 |
| W - m                     | increase the number of windows that can be seen in the current workspace         |
| WS - m                    | decrease the number of windows that can be seen in the current workspace         |
| W - comma                 | go to workspace 0                                                                |
| W - period                | go to workspace 1                                                                |
| WS - comma                | send the window to workspace 0                                                   |
| WS - period               | send the window to workspace 1                                                   |
| W - 1..9                  | choose the (i+1)-th window, press grave for the first window                     |
| WS - 1..9                 | swap the current window to the (i+1)-th position                                 |
| WC - 1..9                 | devide screens to left and right two panes                                       |
| WA - 1..9                 | devide screens to up and down two panes                                          |
| WC - 0                    | leave only one pane per WS                                                       |
| WA - 0                    | leave only one pane per WS                                                       |
| W - 0                     | run screensaver                                                                  |
| WCS - Escape              | LOGOUT                                                                           |
| W - Left_mouse_button     | move window                                                                      |
| W - Middle_mouse_button   | sink all windows, and swap the clicked window to master                          |
| W - Right_mouse_button    | resize window                                                                    |
