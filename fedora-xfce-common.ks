# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Kevin Fenzi       <kevin@tummy.com>
# - Adam Miller       <maxamillion@fedoraproject.org>
# - Mukundan Ragavan  <nonamedotc@fedoraproject.org>

%packages
lightdm-qtquick-greeter
fedora-release-xfce
# install env-group to resolve RhBug:1891500
@^xfce-desktop-environment
@xfce-apps
@xfce-extra-plugins
@xfce-media
gimp
wget
cairo-dock
system-config-printer
serene-desktop-backgrounds-compat
nerd-fonts-noto-mini

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-aspell-*                   # dictionaries are big
-xfce4-sensors-plugin
-xfce4-eyes-plugin

%end
