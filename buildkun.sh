#!/usr/bin/env bash
ksflatten --config fedora-livecd-xfce-ja_JP.ks -o flat.ks --version F36
livemedia-creator --ks flat.ks --no-virt --resultdir /var/lmc --project SereneLinux-Live --make-iso --volid SereneLinux-36 --iso-only --iso-name SereneLinux-Xfce-36-x86_64.iso --releasever 36 --macboot