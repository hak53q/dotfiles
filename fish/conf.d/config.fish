#!/usr/bin/env fish

set -gx LANG zh_TW.UTF-8
export BAT_THEME="ansi"

if test -z "$DISPLAY"; and test "$XDG_VTNR" = "1"
    set -gx LANG en_US.UTF-8
end

starship init fish | source
