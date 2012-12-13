# Michael's Dotfiles

## Description

The newest revision of my dotfiles.  Managed using
[dotfiles](https://github.com/jbernard/dotfiles).

## Highlights

Two-line prompt, standard

    [michael@michael-ubuntu-12:~]  
    ∫
    
Two-line prompt, git-aware

    [michael@michael-ubuntu-12:~/test]  (git:master:c1d0d25) 
    ∫ 

Dircolors, useful aliases, VI input mode.
Xmonad Configuration (.xmonad) with custom .xsession

Useful scripts in .bin and .bin-ros (For ROS http://ros.org).

Will additionally source ~/.bashrc-local and ~/.bashrc-private for local and private settings
Will additionally source ~/.profile-local and ~/.profile-private for local and private settings
Will additionally source ~/.rosrc-local and ~/.rosrc-private for local and private ROS settings

VIM Configurations


## Installation bits

### Necessary for dotfiles

    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install vim vim-gtk git tig git-gui git-svn gitk python-pip \
    xmonad suckless-tools xmobar dwm dmenu ubuntu-restricted-extras rxvt-unicode tmux \
    byobu terminator emacs trayer libghc6-xmonad-contrib-dev scrot cabal-install xclip \
    ack build-essential gufw keychain chrony openssh-server 

    cd /tmp && wget
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb


### Cabal for yeganesh 

    cabal update
    cabal install yeganesh

### Dotfiles

    sudo pip install dotfiles
    mkdir -p ~/devel/lib/dotfiles
    git clone https://github.com/mjcarroll/dotfiles ~/devel/lib/dotfiles
    dotfiles -s -R ~/devel/lib/dotfiles --force

    cd ~/devel/lib/dotfiles
    git submodule init && git submodule update

    sudo cp ~/devel/lib/dotfiles/xsession.desktop
    /usr/share/xsessions/xsession.desktop

### Bumblebee
    sudo add-apt-repository ppa:bumblebee/stable
    sudo add-apt-repository ppa:ubuntu-x-swat/x-updates
    sudo apt-get update
    sudo apt-get install bumblebee bumblebee-nvidia linux-headers-generic

### ROS
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
    wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
