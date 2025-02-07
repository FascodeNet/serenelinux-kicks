# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <cwickert@fedoraproject.org>
# - Kevin Fenzi       <kevin@tummy.com>
# - Adam Miller       <maxamillion@fedoraproject.org>

%include fedora-live-base.ks
%include fedora-live-minimization.ks
%include fedora-xfce-common.ks

# need a bigger /
part / --size 12750

%post
cat > /etc/anaconda/product.d/serene.conf <<EOF

[Product]
product_name = Serene Linux

[Network]
default_on_boot = FIRST_WIRED_WITH_LINK

[Bootloader]
efi_dir = fedora

[Storage]
default_scheme = PLAIN

[User Interface]
default_help_pages =
    SerenePlaceholder.txt
    SerenePlaceholder.html
    SerenePlaceholderWithLinks.html

[Payload]
default_source = CLOSEST_MIRROR

default_rpm_gpg_keys =
    /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

updates_repositories =
    updates
    updates-modular


EOF
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)
sed -i "s|/bin/bash|/usr/bin/zsh|g" /etc/default/useradd
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

# mkdir -p /home/liveuser/.config/xfce4

# cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
# MailReader=sylpheed-claws
# FileManager=Thunar
# WebBrowser=firefox
# FOE

# disable screensaver locking (#674410)
cat >> /home/liveuser/.xscreensaver << FOE
mode:           off
lock:           False
dpmsEnabled:    False
FOE

# deactivate xfconf-migration (#683161)
rm -f /etc/xdg/autostart/xfconf-migration-4.6.desktop || :

# deactivate xfce4-panel first-run dialog (#693569)
# mkdir -p /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml
# cp /etc/xdg/xfce4/panel/default.xml /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set Xfce as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=xfce/' /etc/lightdm/lightdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
sed -i -e 's/Icon=org.fedoraproject.AnacondaInstaller/Icon=system-os-installer/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop


# no updater applet in live environment
rm -f /etc/xdg/autostart/org.mageia.dnfdragora-updater.desktop

# and mark it as executable (new Xfce security feature)
chmod +x /home/liveuser/Desktop/liveinst.desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

