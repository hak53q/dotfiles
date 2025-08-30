#!/usr/bin/env fish

sleep 1m

if not ping -c 1 -W 1 1.1.1.1 > /dev/null 2>&1
    sleep 3m
    fish --no-config /home/hak53q/dotfiles/fish/update-counts.fish
end

set pacman_count (command checkupdates | wc -l)
set aur_count (command paru -Qua | wc -l)
flatpak update --appstream > /dev/null 2>&1
set flatpak_count (command flatpak remote-ls --updates | wc -l)

set total_count (math $pacman_count + $aur_count + $flatpak_count)

echo $total_count > ~/.update-counts.txt

if test $total_count -gt 40
    notify-send -u normal "更新通知" "已有 $total_count 個更新等待中，請儘速更新！"
else if test $total_count -gt 20
    notify-send -u low "更新通知" "$total_count 個套件等待更新"
end

sleep 56m

fish --no-config /home/hak53q/dotfiles/fish/update-counts.fish