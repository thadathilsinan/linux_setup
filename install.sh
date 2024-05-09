#!/bin/bash         

# Ask confirmation
echo "Are you sure to install the Hyprland configuration? (y/N)"
read confirmation

confirmation_lowercase=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')


# Define the function to install a package
function install() {
	echo "Installing $1..."
	
	output="$(yay -S --noconfirm $1 2>&1)"
	exit_code=$?

	if [ $exit_code != 0 ]; then
		echo "Cannot install $1. Please check it manually."
		exit 1
	else
		echo "Installation completed."
	fi
}

# Define the function to install the yay package
function installYay() {
	echo "Install yay..."
	output="$(sudo pacman -S --needed base-devel git 2>&1)"
	mkdir ~/temp-dir
	cd ~/temp-dir
	output="$(git clone https://aur.archlinux.org/yay.git 2>&1)"
	cd yay
	output="$(makepkg -si --noconfirm 2>&1)"
	cd ~
	rm -rf ~/temp-dir
	echo "yay installation completed."
}

if [ "$confirmation_lowercase" == "y" ];
then

echo "Updating package cache..."
output="$(sudo pacman -Syy 2>&1)"
echo "Packages cache update successful."

installYay

echo "Installing required packages...."

packages=(ttf-firacode-nerd
ttf-fira-sans
pavucontrol
xautolock
polkit-gnome
libnotify
gum
fontconfig
pacman-contrib
trizen
neovim
starship
grim
slurp
xclip
swappy
python
python-pywal
sed
libpulse
wireplumber
pipewire
pulseaudio
playerctl
qalculate-gtk
rofi-wayland
alacritty
adobe-source-code-pro-fonts
blueman
bluez
bluez-utils
bluetuith-bin
brightnessctl
cliphist
dunst
emote
enchant
figlet
fuse2
fuse3
git
hypridle
hyprcursor
hyprlang
hyprlock
hyprpaper
imagemagick
icu
jansson
karchive
lame
media-player-info
mousepad
nautilus
networkmanager
network-manager-applet
nwg-look
otf-font-awesome
pango
pfetch
swww
swww-debug
upower
waybar
wlogout)

for package in ${packages[@]}; do
  install $package
done

# Install the dotfiles
echo "Installing dotfiles..."
mkdir ~/dotfiles-clone
cd ~/dotfiles-clone

echo "Downloading dotfiles..."
output="$(git clone https://github.com/thadathilsinan/linux_setup.git 2>&1)"
exit_code=$?
if [ $exit_code != 0 ]; then
	echo "Cannot download the dotfiles. Try again.."
        cd ~
	rm -rf ~/dotfiles-clone
	exit 1
else
        echo "Dotfiles downloaded."
fi

cd linux_setup

yes | cp -rf ./.config ~/
yes | cp -rf ./.local ~/
yes | cp -rf ./.themes ~/
yes | cp -rf ./wallpaper ~/
yes | sudo cp -rf ./usr /
mkdir ~/Tools
yes | sudo cp -rf ./Evolve ~/Tools
yes | sudo cp -f ./.bashrc ~/

cd ~
rm -rf ~/dotfiles-clone
echo "Dotfiles installed."

fi
