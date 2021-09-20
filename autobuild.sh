#!/usr/bin/env bash
mock -r fedora-35-x86_64 --init
mock -r fedora-35-x86_64 --install lorax-lmc-novirt vim-minimal pykickstart
sudo cp *.ks /var/lib/mock/fedora-35-x86_64/root
mock -r fedora-35-x86_64 --shell --enable-network "ksflatten --config fedora-live-xfce.ks -o flat-fedora-live-xfce.ks --version F35"
mock -r fedora-35-x86_64 --shell --enable-network "livemedia-creator --ks flat-fedora-live-xfce.ks --no-virt --resultdir /var/lmc --project Fedora-Xfce-Live --make-iso --volid Fedora-Xfce-35 --iso-only --iso-name Fedora-Xfce-35-x86_64.iso --releasever 35 --macboot"
cp /var/lib/mock/fedora-35-x86_64/root/var/lmc/Fedora-Xfce-35-x86_64.iso out/
mock -r fedora-35-x86_64 --clean