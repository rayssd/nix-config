local colors = require("colors")
local app_icons = require("helpers.app_icons")

-- Padding item required because of bracket
sbar.add("item", { width = 5 })

local apple = sbar.add("item", {
  icon = {
    font = "sketchybar-app-font:Regular:22.0";
    string = app_icons["MongoDB"],
    padding_right = 8,
    padding_left = 8,
    color = colors.darkgreen
  },
  label = { drawing = false },
  -- background = {
  --   color = colors.bg2,
  --   border_color = colors.black,
  --   border_width = 1
  -- },
  padding_left = 1,
  padding_right = 1,
  -- click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})


apple:subscribe("mouse.clicked", function()
  sbar.exec("$CONFIG_DIR/helpers/menus/bin/menus -s 0")
end)

-- Double border for apple using a single item bracket
sbar.add("bracket", { apple.name }, {
  background = {
    color = colors.transparent,
    height = 30,
    border_color = colors.grey,
  }
})

-- Padding item required because of bracket
sbar.add("item", { width = 7 })
