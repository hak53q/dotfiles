#!/usr/bin/env fish
# 此腳本使用chatgpt生成

# 取得所有漫畫資料夾
set mangas (ls -d */)
set total (count $mangas)
set done 0

# 遍歷每個漫畫資料夾
for manga in $mangas
    if test -d "$manga"
        set done (math $done + 1)
        echo "($done/$total)	處理漫畫資料夾：$manga"

        pushd "$manga" > /dev/null

        # 刪除元数据.json
        if test -f "元数据.json"
            echo "	刪除："$manga"元数据.json"
            rm -f "元数据.json"
        end

        # 遍歷章節資料夾
        for chapter in */
            if test -d "$chapter"
                set base (string trim --right --chars=/ "$chapter")
                set cbz "$base.cbz"

                if test -f "$cbz"
                    echo "	已存在，跳過：$manga$cbz"
                else
                    echo "	壓縮: $manga$cbz"
                    bsdtar -a -cf "$cbz" "$chapter"
                    if test -f "$cbz"
                        rm -rf "$chapter"
                    end
                end
            end
        end

        popd > /dev/null
    end
end
