#!/bin/bash
function startCheck() {
	if [[ "$EUID" -eq 0 ]]; then
		echo 'do not run as root'
		exit 1
	fi

	ping -c 1 -q google.com >&/dev/null
	if [[ $? != 0 ]]; then
		echo 'must have internet connection'
		exit 1 
	fi
    
    if [[ "$PWD" != $HOME ]]; then
        echo "this script should be run from $HOME"
        exit 1
    fi
}

function initialConfig() {
	# enable rpmfusion free and nonfree repository
	sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	
    {
        echo "# added for speed:"
        echo "fastestmirror=True"
        echo "max_parallel_downloads=10"
        echo "defaultyes=True"
        echo "keepcache=True"
    } >> /etc/dnf/dnf.conf 
    # install multimedia codecs
    sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
    sudo dnf groupupdate sound-and-video
	# read -p "enter your desired hostname: " hostname
	# sudo hostnamectl set-hostname $hostname
	read -p "is this for work or home: " system
	sudo dnf up -y
	sudo dnf install awesome vim alacritty pavucontrol nodejs httpd fzf rofi nmap feh xrandr xset slock thunar xclip stow 
	if [[ $system == "work" ]]; then
		sudo dnf install onedrive liberation-fonts
	else sudo dnf install yt-dlp steam
	fi

	#rm -d ~/{Documents,Music,Pictures,Public,Templates,Videos}
	git clone --depth 1 https://github.com/makccr/wallpapers 
    #set firefox as default pdf application
    xdg-mime default firefox.desktop application/pdf
}

# https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source
# function vimRecompile(){
#     sudo yum install -y ncurses-devel ruby ruby-devel lua lua-devel luajit \
# 	luajit-devel ctags git python python-devel \
# 	python3 python3-devel tcl-devel \
# 	perl perl-devel perl-ExtUtils-ParseXS \
# 	perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
# 	perl-ExtUtils-Embed
# }

 startCheck
 initialConfig

