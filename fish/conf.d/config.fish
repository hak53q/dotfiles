#!/usr/bin/env fish

##############################################
### 此段落使用 gemini 生成，不保證沒有問題 ###
##############################################

# 姑且是每個字都有讀過還多補了一些注釋，過程如下
# https://gemini.google.com/share/352810a6fb1c

if status is-login
    # 一、取得 fish 原生變數
    # env -i, --ignore-environment (Start with an empty environment)
    set -l fish_native (env -i fish -c "set -n")

    # 二、從 bash 取得環境變數快照
    # -lc (login shell, command) 確保讀取 /etc/profile 及 /etc/profile.d
    set -l envs (env -i bash -lc 'env')

    for entry in $envs
        if string match -q "*=*" -- $entry
            # kv = key+val，大概
            set -l kv (string split -m 1 "=" -- $entry)
            set -l key $kv[1]
            set -l val $kv[2]

            # 三、過濾：如果 key 是 fish 原生有的，或者其他變數，則跳過
            # PATH 另外處理，後導入其餘非原生之變數
            if test "$key" = "PATH"
                for p in (string split ":" $val)
                    # fish_add_path 用來將目錄添加到 $PATH，且預設具備持久性，重開機後依然有效
                    fish_add_path -m $p
                end
            # 排除 fish 原生
            else if not contains $key $fish_native
                # 排除一些裡面不應該出現的，像是 bash 生成的一些 PWD 之類
                if not contains $key PWD OLDPWD SHLVL _
                    # 四、導入至 fish
                    set -gx $key $val
                end
            end
        end
    end
end

##############################################
##############################################

function __update_starship_cwd --on-variable PWD
    set -gx STARSHIP_CUSTOM_CWD (starship-cwd --bypass-cache)
end

__update_starship_cwd

set -gx LANG zh_TW.UTF-8
export BAT_THEME="ansi"

if test -z "$DISPLAY"; and test "$TERM" = "linux"
    set -gx LANG en_US.UTF-8
end

fish_add_path "/home/hak53q/.bun/bin"

starship init fish | source
