#!/usr/bin/env bash
mock -r fedora-34-x86_64 --init
mock -r fedora-34-x86_64 --install lorax-lmc-novirt vim-minimal pykickstart
sudo cp *.ks /var/lib/mock/fedora-34-x86_64/root
mock -r fedora-34-x86_64 --shell --enable-network "ksflatten --config fedora-live-xfce.ks -o flat-fedora-live-xfce.ks --version F34"
mock -r fedora-34-x86_64 --shell --enable-network "livemedia-creator --ks flat-fedora-live-xfce.ks --no-virt --resultdir /var/lmc --project Fedora-Xfce-Live --make-iso --volid Fedora-Xfce-34 --iso-only --iso-name Fedora-Xfce-34-x86_64.iso --releasever 34 --macboot"
cp /var/lib/mock/fedora-34-x86_64/root/var/lmc/Fedora-Xfce-34-x86_64.iso out/
mock -r fedora-34-x86_64 --clean