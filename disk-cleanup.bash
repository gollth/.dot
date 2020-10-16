#!/bin/bash

echo "========================================"
echo "|    Freeing Disk Space                |"
echo "========================================"

echo "|> Analysing Logs"

du -sh /var/log/journal
journalctl --disk-usage

echo "|> Shall I delete these logs?"
sudo rm -rfI /var/log/journal/*


if command -v apt &> /dev/null ; then
    echo "|> Autoremoving APT packages"
    sudo apt autoremove
fi

if command -v flatpak &> /dev/null ; then
    echo "|> Autoremoving unsed Flatpak packages"
    sudo flatpak uninstall --unused
fi

if command -v docker &> /dev/null ; then
    echo "|> Pruning dangling Docker images and build caches"
    sudo docker system prune
fi
