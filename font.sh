sudo pacman -Syu --needed paru 
git clone https://github.com/hak53q/dotfiles/
cd ~/dotfiles/fonts/
git clone https://github.com/hak53q/Plangothic/
cd ~/dotfiles/fonts/Plangothic/otf/
makepkg -si
cd ~/dotfiles/fonts/ms/Arial/
makepkg -si
cd ~/dotfiles/fonts/ms/PMingLiU/
makepkg -si
cd ~/dotfiles/fonts/ms/KaiU/
makepkg -si
cd
paru -S --needed noto-fonts-cjk ttf-fira-code otf-misans{,-tc,-l3}
mkdir -p ~/.config/fontconfig/
cp ~/dotfiles/fonts/fonts.conf ~/.config/fontconfig/fonts.conf
