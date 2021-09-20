#!/usr/bin/env bash
ksflatten --config fedora-livecd-xfce-ja_JP.ks -o flat.ks --version F35
livemedia-creator --ks flat.ks --no-virt --resultdir /var/lmc --project SereneLinux-Live --make-iso --volid SereneLinux-35 --iso-only --iso-name SereneLinux-Xfce-35-x86_64.iso --releasever 35 --macboot