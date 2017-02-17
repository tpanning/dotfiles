#!/bin/sh

# You can use the dconf-editor GUI program to browse and set settings

# Enable visual terminal bell
gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell true
# The other option is frame-flash, which only flashes the title bar of the application that issued the bell
gsettings set org.gnome.desktop.wm.preferences visual-bell-type fullscreen-flash

# Show date in toolbar
gsettings set org.gnome.desktop.interface clock-show-date true
