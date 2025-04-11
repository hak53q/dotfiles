sudo pacman -Syu --needed paru 
git clone https://github.com/hak53q/dotfiles/
cd ~/dotfiles/fonts/
git clone https://github.com/hak53q/Plangothic/
cd ~/dotfiles/fonts/Plangothic/otf/
makepkg -si
cd ~
paru -S --needed noto-fonts-cjk ttf-fira-code ttf-sarasa_ui-{tc,sc,hk,jp}
mkdir -p ~/.config/fontconfig/
cp ~/dotfiles/fonts/fonts.conf ~/.config/fontconfig/fonts.conf
