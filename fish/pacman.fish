#!/usr/bin/env fish

echo "root? [y/N]"
read answer

if test "$answer" = "n" -o "$answer" = ""
    echo "Install Chaotic-AUR & CachyOS Repositories ? [Y/n]"
    read answer

    echo "Edit /etc/pacman.conf (nano) ? [Y/n]"
    read answer

    if test "$answer" = "y" -o "$answer" = ""
        sudo pacman -Sy -needed nano
        sudo nano /etc/pacman.conf
    end
    
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key F3B607488DB35A47

    if test "$answer" = "y" -o "$answer" = ""
        echo ""
        /lib/ld-linux-x86-64.so.2 --help | grep supported
        echo ""
        echo "Install cachyos (default) / v3 / v4 ? [1/2/3]"
        read answer
        set -l conf /etc/pacman.conf
        if test "$answer" = "1" -o "$answer" = ""
            yes | sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
                    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst'
            echo "" | sudo tee -a $conf
            echo "[chaotic-aur]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-mirrorlist" | sudo tee -a $conf
            sudo pacman -Syy
        else if test "$answer" = "2"
            yes | sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
                    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst'
            echo "" | sudo tee -a $conf
            echo "[chaotic-aur]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos-v3]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v3-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos-core-v3]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v3-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos-extra-v3]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v3-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-mirrorlist" | sudo tee -a $conf
            sudo pacman -Syy
        else if test "$answer" = "3"
            yes | sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
                    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-22-1-any.pkg.tar.zst'
            echo "" | sudo tee -a $conf
            echo "[chaotic-aur]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos-v4]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v4-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos-core-v4]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v4-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos-extra-v4]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v4-mirrorlist" | sudo tee -a $conf
            echo "" | sudo tee -a $conf
            echo "[cachyos]" | sudo tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-mirrorlist" | sudo tee -a $conf
            sudo pacman -Syy
        else
            "?"
        end
    else if test "$answer" = "n"
        echo "ok"
    else
        echo "?"
    end
else
    echo "Install Chaotic-AUR & CachyOS Repositories ? [Y/n]"
    read answer

    echo "Edit /etc/pacman.conf (nano) ? [Y/n]"
    read answer

    if test "$answer" = "y" -o "$answer" = ""
        pacman -Sy -needed nano
        nano /etc/pacman.conf
    end

    if test "$answer" = "y" -o "$answer" = ""
        echo ""
        /lib/ld-linux-x86-64.so.2 --help | grep supported
        echo ""
        echo "Install cachyos (default) / v3 / v4 ? [1/2/3]"
        read answer
        set -l conf /etc/pacman.conf
        if test "$answer" = "1" -o "$answer" = ""
            yes | pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
                    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst'
            echo "" | tee -a $conf
            echo "[chaotic-aur]" | tee -a $conf
            echo "Include = /etc/pacman.d/chaotic-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-mirrorlist" | tee -a $conf
            pacman -Syy
        else if test "$answer" = "2"
            yes | pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
                    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst'
            echo "" | tee -a $conf
            echo "[chaotic-aur]" | tee -a $conf
            echo "Include = /etc/pacman.d/chaotic-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos-v3]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v3-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos-core-v3]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v3-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos-extra-v3]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v3-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-mirrorlist" | tee -a $conf
            sudo pacman -Syy
        else if test "$answer" = "3"
            yes | pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
                    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst' \
                    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-22-1-any.pkg.tar.zst'
            echo "" | tee -a $conf
            echo "[chaotic-aur]" | tee -a $conf
            echo "Include = /etc/pacman.d/chaotic-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos-v4]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v4-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos-core-v4]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v4-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos-extra-v4]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-v4-mirrorlist" | tee -a $conf
            echo "" | tee -a $conf
            echo "[cachyos]" | tee -a $conf
            echo "Include = /etc/pacman.d/cachyos-mirrorlist" | tee -a $conf
            pacman -Syy
        else
            "?"
        end
    else if test "$answer" = "n"
        echo "ok"
    else
        echo "?"
    end
end
