#!/usr/bin/env fish

function usage
    echo "用法:"
    echo "    單一導出: vf2static.fish [VF字型檔] [新家族名] [wght] [wdth] [slnt] [--format ttf|otf]"
    echo "    批次導出: vf2static.fish [VF字型檔] [新家族名] --batch [--wght <wghtA~wghtB>|<wghtA wghtB...>] [--wdth <wdth>] [--slnt <slnt>|0] [--format ttf|otf]"
    exit 1
end

if test (count $argv) -lt 3
    usage
end

set INPUT_FONT $argv[1]
set NEW_FAMILY $argv[2]
set FILENAME (string replace -a " " "" $NEW_FAMILY)

function export_static_font_batch --argument-names wght wdth slnt
    set STYLE (switch $wght
        case 100; echo "Thin"
        case 200; echo "ExtraLight"
        case 300; echo "Light"
        case 400; echo "Regular"
        case 500; echo "Medium"
        case 600; echo "Semibold"
        case 700; echo "Bold"
        case 800; echo "ExtraBold"
        case 900; echo "Black"
        case '*'; echo "W$wght"
    end)

    set SLANT_NAME (test $slnt -eq 0; and echo "" || echo "Italic")
    set NAME_STYLE "$STYLE$SLANT_NAME"
    set wdth 106
    set FILE_NAME "$FAMILY_FILENAME-$STYLE-$SLANT_NAME-W$WDTH.ttf"
    set FULL_NAME "$NEW_FAMILY $STYLE $SLANT_NAME"

    # 導出靜態字型
    fonttools varLib.instancer "$INPUT_FONT" wght=$wght wdth=$WDTH slnt=$slnt -o "$FILE_NAME"



    echo "✔ 導出 $FULL_NAME → $FILE_NAME"
end

function export_static_font
    set INPUT_FONT "$argv[1]"
    set NEW_FAMILY "$argv[2]"
    set wght "$argv[3]"
    set wdth "$argv[4]"
    set slnt "$argv[5]"

    set FAMILY_FILENAME (string replace -a " " "-" "$NEW_FAMILY")-w$WGHT-wd$WDTH-sl$SLNT
    set OUTPUT="$FAMILY_FILENAME.ttf"

    echo "→ 導出 $OUTPUT"
    fonttools varLib.instancer "$SRC" wght=$WGHT wdth=$WDTH slnt=$SLNT --output "$OUTPUT"
    gftools fix-names "$OUTPUT" > /dev/null
    echo "✔ 完成 $OUTPUT"
end

if test "$argv[3]" = "--batch"
    set batch_args $argv[4..-1]
    if test (count $batch_args) -eq 1
        set range_str $batch_args[1]
        if string match -q '*~*' $range_str
            set start (string split '~' $range_str)[1]
            set end (string split '~' $range_str)[2]
            for w in (seq $start 100 $end)
                export_static_font "$SRC" "$NEW_FAMILY" $w 106 0
                export_static_font "$SRC" "$NEW_FAMILY" $w 106 -11
            end
        else
            usage
        end
    else if test (count $batch_args) -gt 1
        for w in $batch_args
            export_static_font "$SRC" "$NEW_FAMILY" $w 106 0
            export_static_font "$SRC" "$NEW_FAMILY" $w 106 -11
        end
    else
        echo "Wght 未指定，將執行預設範圍 200~800"
        set default (seq 200 100 800)
        for w in $default
            export_static_font "$SRC" "$NEW_FAMILY" $w 106 0
            export_static_font "$SRC" "$NEW_FAMILY" $w 106 -11
        end   
    end    
else if test (count $argv) -eq 5
    set wght $argv[3]
    set wdth $argv[4]
    set slnt $argv[5]
    export_instance "$SRC" "$NEW_FAMILY" "$wght" "$slnt"
else
    usage
end 

# 轉換為 XML
ttx -q "$FILE_NAME"
set TTX_FILE (string replace .ttf .ttx $FILE_NAME)

# 修改 name table
# sed -i \
#     -e "s|<namerecord nameID=\"1\"[^>]*>.*</namerecord>|<namerecord nameID=\"1\">$NEW_FAMILY</namerecord>|" \
#     -e "s|<namerecord nameID=\"2\"[^>]*>.*</namerecord>|<namerecord nameID=\"2\">$NAME_STYLE</namerecord>|" \
#     -e "s|<namerecord nameID=\"4\"[^>]*>.*</namerecord>|<namerecord nameID=\"4\">$FULL_NAME</namerecord>|" \
#     -e "s|<namerecord nameID=\"6\"[^>]*>.*</namerecord>|<namerecord nameID=\"6\">$FAMILY_FILENAME-$STYLE-$SLANT_NAME</namerecord>|" \
#     "$TTX_FILE"
# 
# 轉回字型
# ttx -q -o "$FILE_NAME" "$TTX_FILE"
# 
# 清理
# rm -f "$TTX_FILE"
# rm -f (string replace .ttf "" $FILE_NAME)"#*.ttx"
