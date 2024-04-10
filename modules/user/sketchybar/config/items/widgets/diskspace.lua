local icon = require("icons")
local color = require("colors")
local settings = require("settings")

local disk = sbar.add("item", "widgets.disk", {
  position = "right",
  icon = {
    string = icon.internaldrive,
    font = {
      style = settings.font.style_map["Regular"],
      size = 15.0,
    },
    color = color.green
  },
  label = { font = { family = settings.font.numbers, } },
  update_freq = 60
  -- y_offset = 6,
  -- width = 0
})

-- local disk_percentage = sbar.add("item", "widgets.disk_percentage", {
--   position = "right",
--   label = { font = { family = settings.font.numbers }},
--   -- y_offset = -4,
--   update_freq = 1
-- })

-- sbar.exec("df | head -2 | tail -1 | awk '{print $5}'", function(percent)
--   disk:set({ label = { string = percent }})
-- end)

disk:subscribe({"routine", "power_source_change", "system_woke"}, function()
  sbar.exec("df /dev/disk3s* | head -2 | tail -1 | awk '{print (1-$4/$2)*100}'", function(percent)
    disk:set({ label = { string = math.floor(percent) .. "%" }})
  end)
end)

-- Background around the disk item
sbar.add("item", "widgets.disk.padding", {
  position = "right",
  width = settings.group_paddings
})


