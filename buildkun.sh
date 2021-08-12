#!/usr/bin/env bash
ksflatten --config fedora-livecd-xfce-ja_JP.ks -o flat.ks --version F34
livemedia-creator --ks flat.ks --no-virt --resultdir /var/lmc --project SereneLinux-Live --make-iso --volid SereneLinux-34 --iso-only --iso-name SereneLinux-Xfce-34-x86_64.iso --releasever 34 --macboot