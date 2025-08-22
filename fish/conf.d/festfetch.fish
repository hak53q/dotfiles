#if status is-interactive && test $SHLVL -eq 1
#    if not test -f /tmp/fish_initialized_$USER
#        fastfetch
#        touch /tmp/fish_initialized_$USER
#    end
#end
