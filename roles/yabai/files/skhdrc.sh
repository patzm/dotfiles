# Open applications
cmd + alt - t: open -n -a "Alacritty"  # Terminal
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
alt + shift - 1 : yabai -m window --space  1 # browser
alt + shift - 2 : yabai -m window --space  2 # dev
alt + shift - 3 : yabai -m window --space  3 # cli
alt + shift - 4 : yabai -m window --space  4 # comm
alt + shift - 5 : yabai -m window --space  5 # org
alt + shift - 6 : yabai -m window --space  6 # float
alt + shift - 7 : yabai -m window --space  7 # free
alt + shift - 8 : yabai -m window --space  8 # private
alt + shift - 9 : yabai -m window --space  9 # vcs
alt + shift - s : yabai -m window --space 11 # conf
# space 0 is reserved for balancing window sizes

# moves focus between spaces 
alt - 1 : yabai -m space --focus  1 # browser
alt - 2 : yabai -m space --focus  2 # dev
alt - 3 : yabai -m space --focus  3 # cli
alt - 4 : yabai -m space --focus  4 # comm
alt - 5 : yabai -m space --focus  5 # org
alt - 6 : yabai -m space --focus  6 # float
alt - 7 : yabai -m space --focus  7 # free
alt - 8 : yabai -m space --focus  8 # private
alt - 9 : yabai -m space --focus  9 # vcs
alt - s : yabai -m space --focus 11 # conf
# space 0 is reserved for balancing window sizes

# toggle window split type
alt - e : yabai -m window --toggle split

# close window
alt - x : yabai -m window --close

# toggle window parent zoom
alt - d : \
    yabai -m window --focus mouse && \
    yabai -m window --toggle zoom-parent

# grid / float window and center on screen
alt - g : \
    yabai -m window --toggle float && \
    yabai -m window --grid 4:4:1:1:2:2

# toggle window zoom fullscreen
alt - w : \
    yabai -m window --focus mouse && \
    yabai -m window --toggle zoom-fullscreen

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
