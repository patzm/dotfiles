local outputFile = os.getenv("HOME") .. "/.cache/display_state.json"

local function handleDisplayChange()
    local screens = hs.screen.allScreens()
    local screenInfo = {}

    for _, screen in ipairs(screens) do
        table.insert(screenInfo, {
            name = screen:name(),
            uuid = screen:getUUID(),
            isPrimary = screen == hs.screen.primaryScreen(),
            frame = {
                x = screen:frame().x,
                y = screen:frame().y,
                w = screen:frame().w,
                h = screen:frame().h
            }
        })
    end

    -- Write JSON to file
    local file = io.open(outputFile, "w")
    file:write(hs.json.encode(screenInfo, true))  -- true = pretty print
    file:write("\n")
    file:close()

    -- Trigger yabai update
    hs.execute(os.getenv("HOME") .. "/.config/yabai/on_display_state_changed.sh " .. outputFile)
end

screenWatcher = hs.screen.watcher.new(handleDisplayChange)
screenWatcher:start()

