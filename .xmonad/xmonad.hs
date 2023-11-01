------------------------------------------------------------------------
-- IMPORTS
------------------------------------------------------------------------
-- Good source for configs https://github.com/gvolpe/nix-config/blob/master/home/programs/xmonad/config.hs
    -- Base
import XMonad
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1, killAllOtherCopies)
import XMonad.Actions.CycleWS (swapNextScreen, toggleOrDoSkip, toggleOrView, toggleWS, moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import qualified XMonad.Actions.TreeSelect as TS
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S
import XMonad.Actions.PerWorkspaceKeys


    -- Data
import Data.Char (isSpace)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Tuple.Extra as TE
import qualified Data.Map as M
import Data.List (sortBy)
import Data.Function (on)
import Control.Monad (forM_, join)
import XMonad.Util.NamedWindows (getName)

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))

import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, docks, docksEventHook, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName

    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Reflect (reflectHoriz)

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

    -- Prompt
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)

    -- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn)
import XMonad.Util.SpawnOnce

   -- For polybar
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------
myFont :: String
myFont = "xft:Mononoki Nerd Font:bold:size=9"

myModMask :: KeyMask
myModMask = mod4Mask       -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty "   -- Sets default terminal
-- myTerminal = "kitty --override window_margin_width=0 tmux new-session \"terminal\""

myBrowser :: String
-- myBrowser = myTerminal ++ " -e lynx "  -- Sets lynx as browser for tree select
myBrowser = "brave --password-store=basic"                 -- Sets brave as browser for tree select

myEditor :: String
myEditor = myTerminal ++ "tmux new-session -A -s NeoVim"

myAppLauncher :: String
-- myAppLauncher = "dmenu_run"
myAppLauncher = "rofi -show run"

myBorderWidth :: Dimension
myBorderWidth = 2          -- Sets border width for windows

myNormColor :: String
myNormColor   = "#292d3e"  -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#f8f8f2"  -- Border color of focused windows

altMask :: KeyMask
altMask = mod1Mask         -- Setting this for use in xprompts

scriptsFolder :: String
scriptsFolder = "$HOME/Scripts/"

-- Colors for polybar
color1, color2, color3, color4 :: String
color1 = "#7F7F7F" -- grey
color2 = "#f8f8f2" -- purple
color3 = "#900000" -- red
color4 = "#f8f8f2" -- white

------------------------------------------------------------------------
-- AUTOSTART
------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook = do
          spawnOnce "~/.xmonad/autostart.sh"
          -- setWMName "LG3D"

------------------------------------------------------------------------
-- XPROMPT SETTINGS
------------------------------------------------------------------------
dtXPConfig :: XPConfig
dtXPConfig = def
      { font                = myFont
      , bgColor             = "#292d3e"
      , fgColor             = "#d0d0d0"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#535974"
      , promptBorderWidth   = 0
      , promptKeymap        = dtXPKeymap
      , position            = Top
--    , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 20
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }

-- The same config above minus the autocomplete feature which is annoying
-- on certain Xprompts, like the search engine prompts.
dtXPConfig' :: XPConfig
dtXPConfig' = dtXPConfig
      { autoComplete        = Nothing
      }

-- A list of all of the standard Xmonad prompts and a key press assigned to them.
-- These are used in conjunction with keybinding I set later in the config.
promptList :: [(String, XPConfig -> X ())]
promptList = [ ("m", manPrompt)          -- manpages prompt
             , ("p", passPrompt)         -- get passwords (requires 'pass')
             , ("g", passGeneratePrompt) -- generate passwords (requires 'pass')
             , ("r", passRemovePrompt)   -- remove passwords (requires 'pass')
             , ("s", sshPrompt)          -- ssh prompt
             , ("x", xmonadPrompt)       -- xmonad prompt
             ]

-- Same as the above list except this is for my custom prompts.
promptList' :: [(String, XPConfig -> String -> X (), String)]
promptList' = [ ("c", calcPrompt, "qalc")         -- requires qalculate-gtk
              ]

------------------------------------------------------------------------
-- CUSTOM PROMPTS
------------------------------------------------------------------------
-- calcPrompt requires a cli calculator called qalcualte-gtk.
-- You could use this as a template for other custom prompts that
-- use command line programs that return a single line of output.
calcPrompt :: XPConfig -> String -> X ()
calcPrompt c ans =
    inputPrompt c (trim ans) ?+ \input ->
        liftIO(runProcessWithInput "qalc" [input] "") >>= calcPrompt c
    where
        trim  = f . f
            where f = reverse . dropWhile isSpace

------------------------------------------------------------------------
-- XPROMPT KEYMAP (emacs-like key bindings for xprompts)
------------------------------------------------------------------------
dtXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
dtXPKeymap = M.fromList $
     map (first $ (,) controlMask)   -- control + <key>
     [ (xK_z, killBefore)            -- kill line backwards
     , (xK_k, killAfter)             -- kill line forwards
     , (xK_a, startOfLine)           -- move to the beginning of the line
     , (xK_e, endOfLine)             -- move to the end of the line
     , (xK_m, deleteString Next)     -- delete a character foward
     , (xK_b, moveCursor Prev)       -- move cursor forward
     , (xK_f, moveCursor Next)       -- move cursor backward
     , (xK_BackSpace, killWord Prev) -- kill the previous word
     , (xK_y, pasteString)           -- paste a string
     , (xK_g, quit)                  -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) altMask)       -- meta key + <key>
     [ (xK_BackSpace, killWord Prev) -- kill the prev word
     , (xK_f, moveWord Next)         -- move a word forward
     , (xK_b, moveWord Prev)         -- move a word backward
     , (xK_d, killWord Next)         -- kill the next word
     , (xK_n, moveHistory W.focusUp')   -- move up thru history
     , (xK_p, moveHistory W.focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]


------------------------------------------------------------------------
-- WORKSPACES
------------------------------------------------------------------------
-- For more icons: https://fontawesome.com/v4/cheatsheet/
-- myWorkspaces = ["1: \xf0ac", "2: \xf07c", "3: \xf121", "4: \xf15c", "5: \xf001", "6: \xf086", "7: \xf26c", "8: \xf188", "9: \xf26c", "10: \xf26c"]
myWorkspaces = ["0: ?", "1: Chat", "2: Notion", "3: Ext Monitor", "4: ?", "5: Browser", "6: File Nav", "7: Work", "8: Info", "9: BG"]
-- myWorkspaces = ["Browser", "Chat", "Notion", "Ext Monitor", "?", "Terminal", "File Nav", "Work", "Info", "BG"]


workspaceZero = myWorkspaces !! 0
workspaceOne = myWorkspaces !! 1
workspaceTwo = myWorkspaces !! 2
workspaceThree = myWorkspaces !! 3
workspaceFour = myWorkspaces !! 4
workspaceFive = myWorkspaces !! 5
workspaceSix = myWorkspaces !! 6
workspaceSeven = myWorkspaces !! 7
workspaceEight = myWorkspaces !! 8
workspaceNine = myWorkspaces !! 9


------------------------------------------------------------------------
-- MANAGEHOOK
------------------------------------------------------------------------
-- Sets some rules for certain programs. Examples include forcing certain
-- programs to always float, or to always appear on a certain workspace.
-- Forcing programs to a certain workspace with a doShift requires xdotool
-- if you are using clickable workspaces. You need the className or title
-- of the program. Use xprop to get this info.

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out
     -- the full name of my clickable workspaces, which would look like:
     -- doShift "<action xdotool super+8>gfx</action>"
     [ className =? "Brave-browser" --> doShift ( workspaceFive )
     , className =? "FileManager"     --> doShift ( workspaceSix )
     , className =? "Pcmanfm"     --> doShift ( workspaceSix )
     , className =? "nvim-qt" --> doShift ( workspaceSeven )
     -- , className =? "Gimp"    --> doFloat
     , className =? "Gcr-prompter"    --> doCenterFloat
     , className =? "Brave"    --> doCenterFloat
     , className =? "CalcResult"    --> doCenterFloat
     , className =? "dzen"    --> doFloat
     , title =? "Oracle VM VirtualBox Manager"     --> doFloat
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     ] 

------------------------------------------------------------------------
-- LOGHOOK
------------------------------------------------------------------------
eventLogHook = do
  winset <- gets windowset
  title <- maybe (return "") (fmap show . getName) . W.peek $ winset
  let currentLayout = description . W.layout . W.workspace . W.current $ winset
  let currWs = W.currentTag winset
  let wss = map W.tag $ W.workspaces winset
  let wsStr = join $ map (fmt currWs) $ sort' wss

  io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
  io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")
  io $ appendFile "/tmp/.xmonad-layout-log" (currentLayout ++ "\n")

  where fmt currWs ws
          | currWs == ws = "[" ++ ws ++ "]"
          | otherwise    = " " ++ ws ++ " "
        sort' = sortBy (compare `on` (!! 0))

------------------------------------------------------------------------
-- LAYOUTS
------------------------------------------------------------------------
-- Makes setting the spacingRaw simpler to write. The spacingRaw
-- module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

tall     = renamed [Replace "Tall"]
           $ limitWindows 12
           $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []

magnified  = renamed [Replace "Magnify"]
           $ magnifier
           $ limitWindows 12
           $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []

monocle  = renamed [Replace "Monocle"]
           $ limitWindows 20 Full

floats   = renamed [Replace "Floats"]
           $ limitWindows 20 simplestFloat

flutter   = renamed [Replace "Flutter"]
           $ limitWindows 3
           $ mySpacing 5
           $ ThreeCol 1 (3/100) (1/4)

coding   = renamed [Replace "Coding"]
           $ reflectHoriz 
           $ limitWindows 3
           $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []

codingMagnify   = renamed [Replace "Coding Magnify"]
           $ magnifier
           $ reflectHoriz 
           $ limitWindows 3
           $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []

codingWide   = renamed [Replace "Coding Wide"]
           $ limitWindows 3
           $ mySpacing 5
           $ ThreeColMid 1 (3/100) (1/3)

codingWideMagnify   = renamed [Replace "Coding Wide Magnify"]
           $ magnifier
           $ limitWindows 3
           $ mySpacing 5
           $ ThreeColMid 1 (3/100) (1/3)

  where
    myTabConfig = def { fontName            = "xft:Mononoki Nerd Font:regular:pixelsize=11"
                      , activeColor         = "#292d3e"
                      , inactiveColor       = "#3e445e"
                      , activeBorderColor   = "#292d3e"
                      , inactiveBorderColor = "#292d3e"
                      , activeTextColor     = "#ffffff"
                      , inactiveTextColor   = "#d0d0d0"
                      }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     coding
                                 ||| codingMagnify
                                 ||| codingWide
                                 ||| codingWideMagnify
                                 ||| noBorders monocle
                                 --
                                 --
------------------------------------------------------------------------
-- KEYBINDINGS
dvorakKeys :: [(String, X ())]
dvorakKeys =
    -- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile && notify-send 'Xmonad Recompiled'")      -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --recompile && xmonad --restart && notify-send 'Xmonad Recompiled & Restarted'")        -- Restarts xmonad
        , ("M-S-q", io exitSuccess)                  -- Quits xmonad
        -- , ("M-<Return>", spawn myTerminal)
        , ("M-<Return>", spawn (myTerminal ++ "-e tmux new-session -A -s Terminal"))
        , ("M-S-<Return>", spawn (myTerminal ++ " --override window_margin_width=0"))

    -- Windows
        , ("M-q", kill1)                           -- Kill the currently focused client
        -- , ("M-S-q", killAll)                         -- Kill all windows on current workspace
        , ("M-<Delete>", withFocused $ windows . W.sink) -- Push floating window back to tile
        , ("M-S-<Delete>", sinkAll)                      -- Push ALL floating windows to tile

        , ("M-d", spawn myAppLauncher)                 -- App launcher

        
    -- Change to workspace
        -- https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Actions-CycleWS.html#g:3
        , ("M-;", toggleOrView workspaceZero)
        , ("M-,", toggleOrView workspaceOne)
        , ("M-.", toggleOrView workspaceTwo)
        , ("M-p", toggleOrView workspaceThree)
        , ("M-!", toggleOrView workspaceFour)
        , ("M-a", toggleOrView workspaceFive)
        , ("M-o", toggleOrView workspaceSix)
        , ("M-e", toggleOrView workspaceSeven)
        , ("M-u", toggleOrView workspaceEight)
        , ("M-i", toggleOrView workspaceNine)
        , ("M-g", swapNextScreen)

        , ("M-S-;", windows $ W.shift workspaceZero)
        , ("M-S-,", windows $ W.shift workspaceOne)
        , ("M-S-.", windows $ W.shift workspaceTwo)
        , ("M-S-p", windows $ W.shift workspaceThree)
        , ("M-S-!", windows $ W.shift workspaceFour)
        , ("M-S-a", windows $ W.shift workspaceFive)
        , ("M-S-o", windows $ W.shift workspaceSix)
        , ("M-S-e", windows $ W.shift workspaceSeven)
        , ("M-S-u", windows $ W.shift workspaceEight)
        , ("M-S-i", windows $ W.shift workspaceNine)


    -- Windows navigation
        -- , ("M-g", windows W.focusMaster)     -- Move focus to the master window
        , ("M-h", windows W.focusDown)       -- Move focus to the next window
        , ("M-l", windows W.focusUp)         -- Move focus to the prev window
        , ("M-S-g", windows W.swapMaster)    -- Swap the focused window and the master window
        , ("M-S-h", windows W.swapDown)      -- Swap focused window with next window
        , ("M-S-l", windows W.swapUp)        -- Swap focused window with prev window
        , ("M-<Backspace>", promote)         -- Moves focused window to master, others maintain order
        -- , ("M1-S-<Tab>", rotSlavesDown)      -- Rotate all windows except master and keep focus in place
        , ("M-C-h", rotAllDown)         -- Rotate all the windows in the current stack
        --, ("M-S-s", windows copyToAll)

        -- Layouts
        , ("M-S-<Tab>", sendMessage NextLayout)                -- Switch to next layout
        , ("M-C-M1-<Up>", sendMessage Arrange)
        , ("M-C-M1-<Down>", sendMessage DeArrange)
        , ("M-f", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
        , ("M-S-<Space>", sendMessage ToggleStruts)         -- Toggles struts
        -- , ("M-S-n", sendMessage $ MT.Toggle NOBORDERS)      -- Toggles noborder
        , ("M-<KP_Multiply>", sendMessage (IncMasterN 1))   -- Increase number of clients in master pane
        , ("M-<KP_Divide>", sendMessage (IncMasterN (-1)))  -- Decrease number of clients in master pane
        , ("M-S-<KP_Multiply>", increaseLimit)              -- Increase number of windows
        , ("M-S-<KP_Divide>", decreaseLimit)                -- Decrease number of windows
        , ("M-<Tab>", nextScreen)  -- Switch focus to next monitor

    -- Apps
        , ("M-b", spawn myBrowser)
        , ("M-t", spawn myEditor)
        , ("M-n", spawn ( "alacritty -e nnn"))
        , ("M-S-n", spawn "pcmanfm")
        , ("M-m", spawn "todo -d")
        , ("M-s", spawn (scriptsFolder ++ "web-search.sh"))
        , ("M-z", spawn (myEditor ++ " $HOME/40_Notebooks/Zettel/00-index.md"))
        , ("M-v", spawn (myTerminal ++ "--override window_margin_width=0 -e --title ScratchPad nvim -c 'normal G' +:Goyo +startinsert! /tmp/scratchpad.md"))

    -- Special Keys
        , ("M-<F1>", spawn (scriptsFolder ++ "toggle-mute.sh"))
        , ("M-<F2>", spawn (scriptsFolder ++ "spotify.sh"))
        , ("M-<F3>", spawn (myTerminal ++ "-e --class Mixer --title PulseMixer pulsemixer"))
        , ("M-<F4>", spawn (scriptsFolder ++ "shutdown.sh"))
        , ("M-<F5>", spawn (scriptsFolder ++ "quick-todo.sh"))
        , ("M-<F6>", spawn (scriptsFolder ++ "long-todo.sh"))
        , ("M-<F7>", spawn "brightnessctl set 20%-")
        , ("M-<F8>", spawn "brightnessctl set +20%")
        , ("M-<F9>", spawn "$HOME/.magBin/screencf")
        , ("M-<F11>", spawn (scriptsFolder ++ "lock-suspend.sh"))
        , ("M-<F12>", spawn (scriptsFolder ++ "lorem.sh"))
        , ("M-<Space>", spawn (scriptsFolder ++ "Touchpad.sh"))
        , ("<Print>", spawn "scrot --focused --quality 100 --file '%Y-%m-%dT%TCT.jpg' -e 'mv $f /tmp/'&& notify-send 'Printed window'")
        , ("M-<Print>", spawn "scrot --quality 100 --file '%Y-%m-%dT%TCT.jpg' -e 'mv $f /tmp/' --select --line style=dash && notify-send 'Printed window'")
        , ("M-<KP_Enter>", spawn (scriptsFolder ++ "calculator.sh"))
        , ("M-<End>", spawn (scriptsFolder ++ "addAbolish.sh"))
        , ("M-<Insert>", spawn (scriptsFolder ++ "get-bookmarks.sh"))
        , ("M-<Page_Down>", spawn (scriptsFolder ++ "translate.sh"))
        , ("M-S-<Insert>", spawn (scriptsFolder ++ "browser-session.sh"))
        , ("M-<Page_Up>", spawn "brave https://eyeplus.closeli.com/device/list")

        ]


------------------------------------------------------------------------
-- MAIN
------------------------------------------------------------------------
main :: IO ()
main = do

-----------------------------------
    xmonad $ ewmh . docks $ defaults { logHook = eventLogHook }


defaults = def
    { handleEventHook     = serverModeEventHookCmd
                            <+> serverModeEventHook
                            <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
    , modMask             = myModMask
    , terminal            = myTerminal
    , workspaces          = myWorkspaces
    , layoutHook          = smartBorders $ myLayoutHook
    , normalBorderColor   = myNormColor
    , focusedBorderColor  = myFocusColor
    , manageHook          = myManageHook <+> manageHook def
    , borderWidth         = myBorderWidth
    , startupHook         = myStartupHook
    } `additionalKeysP` dvorakKeys
