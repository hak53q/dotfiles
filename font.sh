sudo pacman -Syu --needed paru 
paru -S --needed ttf-ms-win10-auto
git clone https://github.com/hak53q/Plangothic/
cd Plangothic/otf/
makepkg -si
cd
rm -rf /home/$USER/Plangothic/
paru -S --needed ttf-rubik-vf
paru -S --needed ttf-fira-code
paru -S --needed ttf-misans{,-tc,-l3}
