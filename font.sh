sudo pacman -Syu --needed paru 
git clone https://github.com/hak53q/Plangothic/
cd ~/Plangothic/otf/
makepkg -si
cd ~
paru -S --needed otf-rubik ttf-fira-code ttf-sarasa_ui-{tc,sc,hc,jp}
mkdir -p ~/.config/fontconfig/
cp ~/dotfiles/fonts/fonts.conf ~/.config/fontconfig/fonts.conf
