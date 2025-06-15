local configDir = os.getenv("HOME") .. "/.hammerspoon"

for file in hs.fs.dir(configDir) do
    if file:match("%.lua$") and file ~= "init.lua" then
        local module = file:gsub("%.lua$", "")
        require(module)
    end
end

