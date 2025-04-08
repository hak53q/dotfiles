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
cd ~/dotfiles/fonts/Kosugi/
makepkg -si
cd
paru -S --needed noto-fonts-cjk ttf-fira-code otf-misans otf-misans-tc otf-misans-l3 otf-misans-latin
mkdir -p ~/.config/fontconfig/
cp ~/dotfiles/fonts/fonts.conf ~/.config/fontconfig/fonts.conf
