local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")
local sbar = require("sketchybar")

sbar.add("event", "aerospace_workspace_change")

local workspaces = {}
local workspace_subscriptions = {}

-- Function to execute shell commands and return the output
local function execute_command(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Create a function for handling workspace changes
local function handle_workspace_change(env, space, space_bracket, workspace_id)
  local selected = env.FOCUSED_WORKSPACE == tostring(workspace_id)
  space:set({
    icon = { highlight = selected },
    label = { highlight = selected },
    background = { border_color = selected and colors.sky or colors.bar.bg },
  })
  space_bracket:set({
    background = { border_color = selected and colors.sky or colors.bar.bg },
  })
end

local function subscribe_to_workspace_events()
  for workspace_id, data in pairs(workspace_subscriptions) do
    local space = data.space
    local space_bracket = data.space_bracket

    if space then
      space:subscribe({ "aerospace_workspace_change" }, function(env)
        handle_workspace_change(env, space, space_bracket, workspace_id)
      end)
    end
  end
end

local function add_workspace(display_id, space_id, workspace_id)
  local space = sbar.add("space", "space." .. workspace_id, {
    space = space_id,
    -- display = display_id,
    icon = {
      font = { family = settings.font.numbers },
      string = tostring(workspace_id),
      padding_left = 15,
      padding_right = 8,
      color = colors.white,
      highlight_color = colors.sky,
    },
    label = {
      padding_right = 20,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.bar.bg,
      border_width = 1,
      height = 26,
      border_color = colors.black,
    },
    popup = { background = { border_width = 5, border_color = colors.black } },
  })

  workspaces[workspace_id] = space

  -- Single item bracket for space items to achieve double border on highlight
  local space_bracket = sbar.add("bracket", { space.name }, {
    background = {
      color = colors.transparent,
      border_color = colors.bg2,
      height = 22,
      border_width = 2,
    },
  })

  -- Padding space
  sbar.add("space", "space.padding." .. workspace_id, {
    space_id = space_id,
    display_id = display_id,
    script = "",
    width = settings.group_paddings,
  })

  -- Store references globally
  workspace_subscriptions[workspace_id] = {
    space = space,
    space_bracket = space_bracket
  }
end

-- Resubscribe periodically to ensure events keep working
local subscription_refresher = sbar.add("item", "subscription_refresher", {
  drawing = false,
  update_freq = 60,
  updates = true,
})

subscription_refresher:subscribe({ "routine" }, function(env)
  -- Re-register the event
  sbar.add("event", "aerospace_workspace_change")
  subscribe_to_workspace_events()
end)

local function set_icon_line(workspace_id)
  sbar.exec(
    [[aerospace list-windows --workspace ]] .. tostring(workspace_id) .. [[ | awk -F '|' '{print $2}']],
    function(appNames)
      local appCounts = {}
      -- Split the input string by newline into individual app names
      for appName in string.gmatch(appNames, "[^\r\n]+") do
        -- Trim leading and trailing whitespace
        appName = appName:match("^%s*(.-)%s*$")
        if appCounts[appName] then
          appCounts[appName] = appCounts[appName] + 1
        else
          appCounts[appName] = 1
        end
      end

      local icon_line = ""
      local no_app = true
      for app, _ in pairs(appCounts) do
        no_app = false
        local lookup = app_icons[app]
        local icon = ((lookup == nil) and app_icons["Default"] or lookup)
        icon_line = icon_line .. icon
      end

      if no_app then
        icon_line = " —"
      end

      if workspace_id == "focused" then
        sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
          for id in focused_workspace:gmatch("%S+") do
            workspaces[tonumber(id)]:set({ label = icon_line })
          end
        end)
      else
        sbar.animate("tanh", 10, function()
          workspaces[tonumber(workspace_id)]:set({ label = icon_line })
        end)
      end
    end
  )
end

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

space_window_observer:subscribe({ "aerospace_workspace_change" }, function(env)
  set_icon_line(env.FOCUSED_WORKSPACE)
end)

space_window_observer:subscribe({ "space_windows_change" }, function()
  set_icon_line("focused")
end)

-- Get monitor information and space relationships
local monitors = {}

-- First get aerospace monitor information
local aerospace_output = execute_command("aerospace list-monitors")
for line in aerospace_output:gmatch("[^\r\n]+") do
  local monitor_id, name = line:match("(%d+) | (.+)")
  if monitor_id and name then
    monitors[name] = {
      aerospace_monitor_id = tonumber(monitor_id),
      display_number = nil, -- will be filled from spacespy
      space_number = nil, -- will be filled from spacespy
    }
  end
end

-- Get the monitor and space information using spacespy
local monitor_cmd =
  [[spacespy | jq -r '.monitors[] | "\(.name)|\(.display_number)|\(.spaces[] | select(.is_current == true) | .space_number)"']]
local spacespy_output = execute_command(monitor_cmd)

for line in spacespy_output:gmatch("[^\r\n]+") do
  local name, display_number, space_number = line:match("(.+)|(%d+)|(%d+)")
  if name and display_number and space_number and monitors[name] then
    monitors[name].display_number = tonumber(display_number)
    monitors[name].space_number = tonumber(space_number)
  end
end

-- Get workspaces for each monitor
for monitor_name, info in pairs(monitors) do
  if info.aerospace_monitor_id and info.display_number and info.space_number then
    local workspace_output = execute_command("aerospace list-workspaces --monitor " .. info.aerospace_monitor_id)
    for workspace_id in workspace_output:gmatch("[^\r\n]+") do
      add_workspace(info.display_number, info.space_number, tonumber(workspace_id))
    end
  end
end

local ok, ws = pcall(function()
  return execute_command("aerospace list-workspaces --focused"):gsub("%s+", "")
end)
local init_focused_workspace = ok and tonumber(ws) or -1

-- initial run
sbar.trigger("aerospace_workspace_change", { FOCUSED_WORKSPACE = init_focused_workspace })

-- Set up initial subscriptions
subscribe_to_workspace_events()
