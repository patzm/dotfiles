# for this to work you must configure sudo such that
# it will be able to run the command without password

yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
sudo yabai --load-sa

# Binary Space Partitioning (BSP) layout
yabai -m config layout bsp

# Space 1 has all windows floating
# yabai -m config --space 1 layout float

# Set all padding and gaps to Xpt (default: 0)
yabai -m config top_padding    3
yabai -m config bottom_padding 3
yabai -m config left_padding   3
yabai -m config right_padding  3
yabai -m config window_gap     5

# on or off (default: off)
yabai -m config auto_balance off

# 🐁 Mouse support
# set mouse interaction modifier key (default: fn)
yabai -m config mouse_modifier fn

# set modifier + left-click drag to move window (default: move)
yabai -m config mouse_action1 move

# set modifier + right-click drag to resize window (default: resize)
yabai -m config mouse_action2 resize

# set mouse follows focus mode (default: off)
yabai -m config mouse_follows_focus on

# Application rules
yabai -m rule --add app="^System Settings$" manage=off
yabai -m rule --add app="^Calculator$" manage=off
yabai -m rule --add app="iStat Menus.*" manage=off mouse_follows_focus=off

echo "yabai configuration loaded."
