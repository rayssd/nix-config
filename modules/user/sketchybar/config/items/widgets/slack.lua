local app_icons = require("helpers.app_icons")
local colors = require("colors")
local settings = require("settings")

local slack = sbar.add("item", "widgets.slack", {
  position = "left",
  icon = {
    font = "sketchybar-app-font:Regular:16.0";
    string = app_icons["Slack"],
    padding_right = 8,
    padding_left = 8,
    drawing = false,
    color = colors.rosewater
  },
  label = {
    font = {
      family = settings.font.numbers,
      size = 16,
    },
    drawing = false,
    color = colors.rosewater
  },
  update_freq = 1
})

slack:subscribe({"routine"}, function()
  sbar.exec("lsappinfo info -only StatusLabel 'Slack'", function(output)
    local value = output:match('"%w+"=%s*{ "label"="([^"]*)" }')
    if value ~= "" then
      value = tonumber(value)
    else
      value = 0
    end
    local drawing = value > 0 and true or false
    slack:set({
      label = {
          string = value,
          drawing = drawing
        },
      icon = { drawing = drawing }
    })
  end)
end)

-- Background around the slack item
sbar.add("item", "widgets.slack.padding", {
  position = "left",
  width = settings.group_paddings
})
