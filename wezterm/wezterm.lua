-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local gpus = wezterm.gui.enumerate_gpus()
config.webgpu_preferred_adapter = gpus[1]
config.enable_kitty_graphics = true

config.front_end = "WebGpu"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.cell_width = 1.0
config.window_background_opacity = 0.85
config.font_size = 13.5

config.window_padding = {
    left = 6,
    right = 6,
    top = 6,
    bottom = 6,
}

config.enable_tab_bar = false
config.color_scheme = "Dracula"

config.window_frame = {
    font = wezterm.font({
        family = "JetBrainsMono Nerd Font",
        weight = "Regular",
    }),
    active_titlebar_bg = "#0c0b0f",
}

return config
