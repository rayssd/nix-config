local icon = require("icons")
local colors = require("colors")
local settings = require("settings")

local memory = sbar.add("item", "widgets.memory", {
  position = "right",
  icon = {
    string = icon.memorychip,
    font = {
      style = settings.font.style_map["Regular"],
      size = 15.0,
    },
    color = colors.lavender,
  },
  label = { font = { family = settings.font.numbers, } },
  update_freq = 30
})

memory:subscribe({"routine"}, function()
  sbar.exec("vm_stat", function(vm_stat_output)
    local anonymous_pages = tonumber(vm_stat_output:match("Anonymous pages%s*:%s*(%d+)"))
    local pages_free = tonumber(vm_stat_output:match("Pages free%s*:%s*(%d+)"))
    local pages_wired_down = tonumber(vm_stat_output:match("Pages wired down%s*:%s*(%d+)"))
    -- local pages_active = tonumber(vm_stat_output:match("Pages active%s*:%s*(%d+)"))
    -- local pages_inactive = tonumber(vm_stat_output:match("Pages inactive%s*:%s*(%d+)"))
    -- local pages_speculative = tonumber(vm_stat_output:match("Pages speculative%s*:%s*(%d+)"))
    -- local pages_throttled = tonumber(vm_stat_output:match("Pages throttled%s*:%s*(%d+)"))
    local pages_purgeable = tonumber(vm_stat_output:match("Pages purgeable%s*:%s*(%d+)"))
    local pages_occupied_by_compressor = tonumber(vm_stat_output:match("Pages occupied by compressor%s*:%s*(%d+)"))
    local file_backed_pages = tonumber(vm_stat_output:match("File%-backed pages%s*:%s*(%d+)"))
    local app_memory = anonymous_pages - pages_purgeable
    local percentage = (app_memory + pages_wired_down + pages_occupied_by_compressor)/(app_memory + pages_wired_down + pages_occupied_by_compressor + file_backed_pages + pages_purgeable + pages_free) * 100
    memory:set({ label = { string = math.floor(percentage) .. "%" }})
  end)
end)

-- Background around the memory item
sbar.add("item", "widgets.memory.padding", {
  position = "right",
  width = settings.group_paddings
})
