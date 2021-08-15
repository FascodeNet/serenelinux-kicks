# fedora-livecd-xfce-ja_JP.ks
#
# Description:
# - Japanese Fedora Live Spin with the Xfce Desktop Environment
#
# Maintainer(s):
# - Shintaro Fujiwara <shintaro.fujiwara@miraclelinux.com>

%include fedora-live-xfce.ks

# lang ja_JP.UTF-8
keyboard jp
timezone Asia/Tokyo

%packages
langpacks-ja
fcitx
fcitx-configtool
fcitx-anthy
fcitx-qt5

%end

%post
cat > /etc/lightdm/lightdm-qtquick-greeter.json << "EOF"
{ 
    "background_path":"file://usr/share/backgrounds/serene/serene-wallpaper-1.png",
    "theme":"qrc:/Login.qml"
}
EOF
sed -i "s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-qtquick-greeter/g" /etc/lightdm/lightdm.conf
mkdir -p /etc/dconf/db/local.d/
cat > /etc/dconf/db/local.d/jp_serene << "EOF"
[desktop/ibus/general]
engines-order=['anthy', 'xkb:jp::jpn']
preload-engines=['anthy']
EOF
cat > /etc/dconf/db/local.d/serenelinux << "EOF"
[net/launchpad/plank/docks/dock1]
alignment='center'
auto-pinning=true
current-workspace-only=false
dock-items=['gimp.dockitem', 'firefox.dockitem', 'vlc.dockitem', 'xfce4-screenshooter.dockitem', 'thunar.dockitem', 'xfce4-terminal.dockitem']
hide-delay=50
hide-mode='intelligent'
icon-size=45
items-alignment='center'
lock-items=false
monitor=''
offset=0
pinned-only=false
position='bottom'
pressure-reveal=false
show-dock-item=false
theme='Arc'
tooltips-enabled=true
unhide-delay=0
zoom-enabled=false
zoom-percent=150
EOF
dconf update
cp -rf /usr/share/serenekun/etc /
sed -i "s/en_US/ja_JP/g" /etc/locale.conf
cat > /etc/X11/xorg.conf.d/00-keyboard.conf << "EOF"
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "jp"
        Option "XkbModel" "jp106"
EndSection
EOF
%end