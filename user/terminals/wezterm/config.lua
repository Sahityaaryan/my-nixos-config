
-- Source (from) where I have followed the configurations of the wezterm :- https://dev.to/lovelindhoni/make-wezterm-mimic-tmux-5893

------------------------------> configuration <-----------------------------------------


-- Pull in the wezterm API
local wezterm = require("wezterm")
local action = wezterm.action
local config = wezterm.config_builder()

----------------------------------------------------------------
-- 1. HELPER FUNCTIONS (Must be defined before config.keys)
----------------------------------------------------------------

-- Helper for Neovim/WezTerm navigation
local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
  -- reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane) -- FIXED: changed 'w' to 'wezterm'
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end


----------------------------------------------------------------
-- 2. APPEARANCE (Tabs, Opacity, Background)
----------------------------------------------------------------

-- Hides the top tab bar completely
config.enable_tab_bar = false 

-- Removes the OS title bar but keeps resizing borders
config.window_decorations = "RESIZE"

-- Sets transparency of the window content
config.window_background_opacity = 0.85

-- BACKGROUND CONFIGURATION
-- We use the advanced 'config.background' instead of 'window_background_image'
-- to prevent stretching.
config.background = {
  {
    source = {
      -- REPLACE THIS PATH WITH YOUR OWN IMAGE
      -- File = '/home/sahitya/.dotfiles/user/public/desktop.png',
      -- File = '/home/sahitya/.dotfiles/user/public/angry-devi.jpg',
      -- File = '/home/sahitya/.dotfiles/user/public/arjun.jpg',
      -- File = '/home/sahitya/.dotfiles/user/public/goku-2-u-2.png',
       File = '/home/sahitya/.dotfiles/user/public/goku-3.jpg',
      -- File = '/home/sahitya/.dotfiles/user/public/karna-2-u-3.jpg',
    },
    -- "Cover": Scales image to fill window (crops edges, no stretching)
    -- "Contain": Shows entire image (adds black bars, no stretching)
    height = "Cover",
    width  = "Cover",
    
    -- Optional: Align image (Center, Top, Bottom, Left, Right)
    horizontal_align = "Center",
    repeat_x = "NoRepeat",
    vertical_align = "Middle",
    repeat_y = "NoRepeat",
    
    -- Optional: Dim the image (0.1 is very dark, 1.0 is normal)
    hsb = {
      brightness = 0.1, 
      -- hue = 1.0,
      -- saturation = 1.0,
    },
    
    -- Optional: Parallax effect (image moves slower than text when scrolling)
    -- attachment = { Parallax = 0.98 },
  }
}

config.window_frame = { font_size = 13.0 }
config.window_padding = { top = 10, bottom = 10, left = 10, right = 10 }
config.term = "xterm-256color"


----------------------------------------------------------------
-- 3. KEY BINDINGS (All in one place)
----------------------------------------------------------------

config.keys = {
  -- SPLITTING PANES
  {
    key = "UpArrow",
    mods = "CTRL",
    action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "DownArrow",
    mods = "CTRL",
    action = action.SplitHorizontal({ domain = "CurrentPaneDomain" })
  },

  -- ADJUSTING PANE SIZE (Standard WezTerm bindings)
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = action.AdjustPaneSize({ "Left", 5 }),
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = action.AdjustPaneSize({ "Right", 5 }),
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = action.AdjustPaneSize({ "Down", 5 }),
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = action.AdjustPaneSize({ "Up", 5 }),
  },
  {
    key = "m",
    mods = "LEADER",
    action = action.TogglePaneZoomState,
  },

  -- TAB CONFIGURATIONS
  {
    key = "c",
    mods = "LEADER",
    action = action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "p",
    mods = "LEADER",
    action = action.ActivateTabRelative(-1),
  },
  {
    key = "n",
    mods = "LEADER",
    action = action.ActivateTabRelative(1),
  },

  -- SMART SPLITS (Neovim Integration)
  -- Move between split panes
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- Resize panes (using META/ALT key logic from your snippet)
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
}

----------------------------------------------------------------
-- 4. RETURN CONFIG
----------------------------------------------------------------

return config


