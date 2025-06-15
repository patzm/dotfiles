# for this to work you must configure sudo such that
# it will be able to run the command without password

yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
sudo yabai --load-sa

# Binary Space Partitioning (BSP) layout
yabai -m config layout bsp

# Assign space names
yabai -m space 1 --label browser
yabai -m space 2 --label dev
yabai -m space 3 --label cli
yabai -m space 4 --label comm
yabai -m space 5 --label org
yabai -m space 6 --label float
yabai -m space 7 --label free
yabai -m space 8 --label private
yabai -m space 9 --label vcs

# Space 6 has all windows floating
yabai -m config --space float layout float

# Set all padding and gaps to Xpt (default: 0)
yabai -m config top_padding    3
yabai -m config bottom_padding 3
yabai -m config left_padding   3
yabai -m config right_padding  3
yabai -m config window_gap     5

# render all unfocused windows with 95% opacity
yabai -m config window_shadow float
yabai -m config window_opacity on
yabai -m config active_window_opacity 1.00
yabai -m config normal_window_opacity 0.95

# on or off (default: off)
yabai -m config auto_balance off

# 🐁 Mouse support
# set mouse interaction modifier key (default: fn)
yabai -m config mouse_modifier alt

# set modifier + left-click drag to move window (default: move)
yabai -m config mouse_action1 move

# set modifier + right-click drag to resize window (default: resize)
yabai -m config mouse_action2 resize

# set mouse follows focus mode (default: off)
yabai -m config mouse_follows_focus on

# Application rules
yabai -m rule --add app="^Bartender .*$" manage=off
yabai -m rule --add app="^Calculator$" manage=off
yabai -m rule --add app="^iStat Menus$" manage=off
yabai -m rule --add app="^nextcloud$" manage=off
yabai -m rule --add app="^System Settings$" manage=off
yabai -m rule --add app="iStat Menus.*" manage=off mouse_follows_focus=off
yabai -m rule --add app="ONLYOFFICE" manage=on
yabai -m rule --add app="^Firefox$" title=".*Bitwarden Password Manager.*$" manage=off

echo "yabai configuration loaded."
