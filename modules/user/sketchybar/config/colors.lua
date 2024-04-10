return {
  black = 0xff181819,
  white = 0xffe2e2e3,
  -- red = 0xfffc5d7c,
  -- green = 0xff9ed072,
  -- blue = 0xff76cce0,
  -- yellow = 0xffe7c664,
  orange = 0xfff39660,
  magenta = 0xffb39df3,
  grey = 0xff7f8490,
  transparent = 0x00000000,

  -- Catppuccin Mocha colour palette
  rosewater = 0xf0f5e0dc,
  flamingo = 0xf0f2cdcd,
  pink = 0xf0f5c2e7,
  mauve = 0xf0cba6f7,
  red = 0xf0f38ba8,
  maroon = 0xf0eba0ac,
  peach = 0xf0fab387,
  yellow = 0xf0f9e2af,
  green = 0xf0a6e3a1,
  teal = 0xf094e2d5,
  sky = 0xf089dceb,
  sapphire = 0xf074c7ec,
  blue = 0xf089b4fa,
  lavender = 0xf0b4befe,
  text = 0xf0cdd6f4,
  subtext1 = 0xf0bac2de,
  subtext0 = 0xf0a6adc8,
  overlay2 = 0xf09399b2,
  overlay1 = 0xf07f849c,
  overlay0 = 0xf06c7086,
  surface2 = 0xf0585b70,
  surface1 = 0xf045475a,
  surface0 = 0xf0313244,
  base = 0xf01e1e2e,
  mantle = 0xf0181825,
  crust = 0xf011111b,
  -- Catppuccin Mocha colour palette

  darkgreen = 0xf040a02b,

  bar = {
    bg = 0xff000000,
    -- bg = 0xf01e1e2e,
    border = 0xff2c2e34,
  },
  popup = {
    -- bg = 0xc02c2e34,
    bg = 0xf01e1e2e,
    border = 0xff7f8490
  },
  bg1 = 0xff363944,
  bg2 = 0xff414550,


  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
