-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function () 
    hl.exec_cmd("dbus-update-activation-environment --all")
    hl.exec_cmd("waybar & hyprpaper & hypridle")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("syncthing --no-browser")
    hl.exec_cmd("/usr/bin/dunst")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg")
    hl.exec_cmd("nwg-look -a")
end)