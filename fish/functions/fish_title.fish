#!/usr/bin/env fish
# 此腳本使用ChatGPT生成

function fish_title
    set -q argv[1]; or set argv fish
    set -l pwd_path (pwd)
    set -l comps    (string split '/' $pwd_path)
    set comps $comps[2..-1]
    set -l total (count $comps)
    set -l processed
    # 被裁減掉的資料夾數目
    set -l truncation_length 2
    # 截斷的字元數
    set -l max_abbrev_len   2

    # 如果在 $HOME ，就處理前兩層
    if string match -q -- "$HOME/*" $pwd_path
        # comps[1] -> "home"；comps[2] -> "$USER"
        set processed \
            (string sub -s 1 -l $max_abbrev_len -- $comps[1]) \
            (string sub -s 1 -l $max_abbrev_len -- $comps[2])
        set -l rem_list $comps[3..-1]
        set -l rem_count (count $rem_list)

        for idx in (seq 1 $rem_count)
            set comp $rem_list[$idx]
            # 如果剩餘 > trunc_length，且當前層在前 rem_count-trunc 範圍內，就縮寫
            if test $rem_count -gt $truncation_length -a \
                    $idx -le (math $rem_count - $truncation_length)
                set processed $processed \
                    (string sub -s 1 -l $max_abbrev_len -- $comp)
            else
                set processed $processed $comp
            end
        end

    else
        # 不在 $HOME，就全路徑按 truncation_length 處理
        for i in (seq 1 $total)
            set comp $comps[$i]
            if test $i -le (math $total - $truncation_length)
                set processed $processed \
                    (string sub -s 1 -l $max_abbrev_len -- $comp)
            else
                set processed $processed $comp
            end
        end
    end

    echo /(string join '/' $processed)
end
