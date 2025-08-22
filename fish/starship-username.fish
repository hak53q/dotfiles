#!/usr/bin/env fish

set user $(whoami)

if [ $user = hak53q ]

  if [ -f $HOME/.update-counts.txt ]
    set count $(cat $HOME/.update-counts.txt)
  else
    set count 0
  end

  if test $count -gt 999
    set num $(math $count / 1000)
    set int $(bash -c 'num=$1; int=${num%.*}; echo "$int"' bash $num)
    echo hak"$int"Tq > $HOME/.starship_username
  else if test $count -gt 99
    set num $(math $count / 100)
    set int $(bash -c 'num=$1; int=${num%.*}; echo "$int"' bash $num)
    echo hak"$int"Hq > $HOME/.starship_username
  else if test $count = 53
    echo hak"$count"Q > $HOME/.starship_username
  else if test $count -gt 9
    echo hak"$count"q > $HOME/.starship_username
  else
    echo $user > $HOME/.starship_username
  end

else
  echo $user > $HOME/.starship_username
end

sleep 10

fish --no-config $HOME/dotfiles/fish/username.fish
