function fish_title
    set -q argv[1]; or set argv fish

    set path_components (string split '/' (pwd))
    set truncation_length 2
    set max_abbrev_len 2

    set -l total (count $path_components)

    set -l processed_components

    for i in (seq 1 $total)
        set comp $path_components[$i]
        if test -z "$comp"
            continue
        end

        if test $i -le (math $total - $truncation_length)
            set processed_components $processed_components (string sub -s 1 -l $max_abbrev_len -- $comp)
        else
            set processed_components $processed_components $comp
        end
    end

    echo /(string join '/' $processed_components)
end
