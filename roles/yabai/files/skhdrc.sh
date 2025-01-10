# Open applications
cmd + alt - t: open -n -a "Alacritty"
cmd + alt - f: open ~/Downloads  # Finder opens the Downloads folder

# moves focus between windows in the current focused display
alt - h : yabai -m window --focus west
alt - j : yabai -m window --focus south
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east

# move window
alt + shift - h : yabai -m window --warp west
alt + shift - j : yabai -m window --warp south
alt + shift - k : yabai -m window --warp north
alt + shift - l : yabai -m window --warp east

# send window to a space 
alt + shift - 1 : yabai -m window --space browser
alt + shift - 2 : yabai -m window --space dev
alt + shift - 3 : yabai -m window --space cli
alt + shift - 4 : yabai -m window --space comm
alt + shift - 5 : yabai -m window --space org
alt + shift - 6 : yabai -m window --space float
alt + shift - 7 : yabai -m window --space free
alt + shift - 8 : yabai -m window --space private
alt + shift - 9 : yabai -m window --space vcs
# space 0 is reserved for balancing window sizes

# moves focus between spaces 
alt - 1 : yabai -m space --focus browser
alt - 2 : yabai -m space --focus dev
alt - 3 : yabai -m space --focus cli
alt - 4 : yabai -m space --focus comm
alt - 5 : yabai -m space --focus org
alt - 6 : yabai -m space --focus float
alt - 7 : yabai -m space --focus free
alt - 8 : yabai -m space --focus private
alt - 9 : yabai -m space --focus vcs
# space 0 is reserved for balancing window sizes

# toggle window split type
alt - e : yabai -m window --toggle split

# close window
alt - x : yabai -m window --close

# toggle window parent zoom
alt - d : yabai -m window --focus mouse && \
          yabai -m window --toggle zoom-parent

# grid / float window and center on screen
alt - g : yabai -m window --toggle float;\
          yabai -m window --grid 4:4:1:1:2:2

# toggle window fullscreen zoom
alt + shift - w :   yabai -m window --focus mouse && \
                    yabai -m window --toggle zoom-fullscreen

# toggle window native fullscreen
alt - w : yabai -m window --toggle native-fullscreen

# balance size of windows
alt + shift - 0 : yabai -m space --balance

# create a new space and follow focus
ctrl + alt - n : \
    yabai -m space --create && \
    index="$(yabai -m query --displays --display | jq '.spaces[-1]')" && \
    yabai -m space --focus "${index}"

# create a new space, move window and follow focus
ctrl + alt + shift - n : \
    yabai -m space --create && \
    index="$(yabai -m query --displays --display | jq '.spaces[-1]')" && \
    yabai -m window --space "${index}" && \
    yabai -m space --focus "${index}"

# delete focused space
alt - q : yabai -m space --destroy

# restart yabai
ctrl + alt + cmd - r : yabai --restart-service
