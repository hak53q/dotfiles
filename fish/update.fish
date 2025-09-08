#!/usr/bin/env fish
# 此腳本部分使用ChatGPT生成

set flag_list 0
set flag_pacman 0
set flag_aur 0
set flag_flatpak 0
set has_updates 0
set list_update 0



for arg in $argv
    switch $arg
        case l -l --list
            set flag_list 1
        case p -p --pacman
            set flag_pacman 1
        case a -a --aur
            set flag_aur 1
        case f -f --flatpak
            set flag_flatpak 1
        case pa ap
            set flag_pacman 1
            set flag_aur 1
        case af fa
            set flag_aur 1
            set flag_flatpak 1
        case pf fp
            set flag_pacman 1
            set flag_flatpak 1
        case u
            set list_update 1
        case '*'
            echo "未知參數: $arg"
            exit 1
    end
end



if test $flag_list -eq 0 -a $flag_pacman -eq 0 -a $flag_aur -eq 0 -a $flag_flatpak -eq 0 -a $list_update -eq 0
    paru -Syu --disable-download-timeout
    flatpak update
end



if test $flag_list -eq 1

    echo 正在檢查更新…

    set pacman_updates (checkupdates --nocolor)
    set aur_updates (paru -Qua)
    set flatpak_updates (flatpak update --appstream > /dev/null 2>&1; flatpak remote-ls --columns=application,version --updates)
    
    if test -n "$pacman_updates"
        echo "$(tput bold)Pacman 更新：$(tput sgr0)"
        for line in $pacman_updates
            echo $line
        end
        set has_updates 1
    end

    if test -n "$aur_updates"
        echo "$(tput bold)AUR 更新 ：$(tput sgr0)"
        for line in $aur_updates
            echo $line
        end
        set has_updates 1
    end

    if test -n "$flatpak_updates"
        echo "$(tput bold)Flatpak 更新：$(tput sgr0)"
        for line in $flatpak_updates
            echo $line
        end
        set has_updates 1
    end

    if test $has_updates -eq 0
        echo "當前無可用更新"
    end

end



if test $list_update -eq 1

    echo 正在檢查更新…

    set pacman_updates (checkupdates --nocolor)
    set aur_updates (paru -Qua)
    set flatpak_updates (flatpak update --appstream > /dev/null 2>&1;flatpak remote-ls --columns=application,version --updates)

    if test -n "$pacman_updates"
        echo "$(tput bold)Pacman 更新：$(tput sgr0)"
        for line in $pacman_updates
            echo $line
        end
        set has_updates 1
        set flag_pacman 1
    end

    if test -n "$aur_updates"
        echo "$(tput bold)AUR 更新 ：$(tput sgr0)"
        for line in $aur_updates
            echo $line
        end
        set has_updates 1
        set flag_aur 1
    end

    if test -n "$flatpak_updates"
        echo "$(tput bold)Flatpak 更新：$(tput sgr0)"
        for line in $flatpak_updates
            echo $line
        end
        set has_updates 1
        set flag_flatpak 1
    end

    if test $has_updates -eq 0
        echo "當前無可用更新"
    end

end



if test $flag_pacman -eq 1
    sudo pacman -Syu --disable-download-timeout
end



if test $flag_aur -eq 1
    paru -Sua
end



if test $flag_flatpak -eq 1
    flatpak update
end 
