local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

-- ============================================================================
-- 1. THEMES & VISUALS
-- ============================================================================
-- config.default_cursor_style = "BlinkingBlock"
-- config.cursor_blink_rate = 600
-- config.cursor_blink_ease_out = "Linear"
-- config.force_reverse_video_cursor = true
-- config.color_scheme = "Obsidian (Gogh)"
-- config.color_scheme = 'One Light (base16)'
-- config.color_scheme = 'Oxocarbon Dark (Gogh)'
-- config.color_scheme = 'dirtysea (base16)'
-- config.color_scheme = 'One Half Black (Gogh)'
-- config.color_scheme = 'Gruvbox (Gogh)'
-- config.color_scheme = 'Gruvbox light, hard (base16)'
-- config.color_scheme = 'Humanoid light (base16)'
-- config.color_scheme = 'Gruvbox Material (Gogh)'
-- config.color_scheme = 'OneHalfDark'
-- config.color_scheme = 'Builtin Solarized Dark'
-- config.color_scheme = 'Solarized Dark Higher Contrast'
-- config.color_scheme = 'Solarized Light (Gogh)'
-- config.color_scheme = "Dracula (Official)"
-- config.color_scheme = 'flexoki-dark'
-- config.color_scheme = 'Solarized Darcula'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = "Monokai Vivid"

config.color_scheme = "Tokyo Night" -- Active Theme

config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 12
config.window_decorations = "RESIZE"
config.window_padding = { bottom = 0 }

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5
}

-- ============================================================================
-- 2. CORE BEHAVIOR & SHELL
-- ============================================================================
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 10000
config.default_workspace = "home"

config.default_prog = { 'nu' }
config.set_environment_variables = {
  SHELL = 'nu',
}

config.launch_menu = {
  { label = 'PowerShell', args = { 'powershell.exe', '-NoLogo' } }
}

-- ============================================================================
-- 3. KEYBINDINGS
-- ============================================================================
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
  -- Send C-SPC when pressing C-SPC twice
  { key = "Space", mods = "LEADER",       action = act.SendKey { key = "Space", mods = "CTRL" } },
  { key = "C",     mods = "LEADER",       action = act.ActivateCopyMode },
  { key = "phys:Space", mods = "LEADER",  action = act.ActivateCommandPalette },

  -- Pane Management
  { key = "-", mods = "LEADER",       action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
  { key = "x", mods = "LEADER",       action = act.CloseCurrentPane { confirm = true } },
  { key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },

  -- Tab Management
  { key = "t", mods = "LEADER",       action = act.ShowTabNavigator },
  { key = 'c', mods = 'LEADER',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'LEADER',       action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER',       action = act.ActivateTabRelative(-1) },
  { key = '&', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = true } },
  
  -- Tab/Workspace Renaming Prompts
  {
    key = ",", mods = "LEADER",
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then window:active_tab():set_title(line) end
      end),
    }
  },
  {
    key = '$', mods = 'LEADER|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for workspace',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    }
  },

  -- Workspace & KeyTables
  { key = "s", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
  { key = "m", mods = "LEADER", action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
}

-- Quick tab navigation with index (LDR + 1-9)
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1)
  })
end

-- ============================================================================
-- 4. KEY TABLES
-- ============================================================================
config.key_tables = {
  move_tab = {
    { key = 'h', action = act.MoveTabRelative(-1) },
    { key = 'l', action = act.MoveTabRelative(1) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  }
}

return config
