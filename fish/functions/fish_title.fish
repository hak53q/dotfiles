function fish_title
    set -q argv[1]; or set argv fish
    if test (pwd) = ~
        echo (whoami)@(uname -n):(pwd)
    else
        echo (whoami)@(uname -n):(prompt_pwd)
    end
end
