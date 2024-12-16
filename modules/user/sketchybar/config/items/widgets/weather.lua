local settings = require("settings")

local weather = sbar.add("item", "widgets.weather", {
  position = "right",
  label = { font = { family = settings.font.number, } },
  update_freq = 1800
})

weather:subscribe({"routine", "power_source_change", "system_woke"}, function()
  sbar.exec("curl -s 'https://wttr.in/Sydney,Australia?format=2'", function(output)
    if string.len(output) < 50 then
      weather:set({ label = { string = output }})
    else
      weather:set({ label = { string = "No weather report :(" }})
    end
  end)
end)

