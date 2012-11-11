# Michael's Dotfiles

## Description

The newest revision of my dotfiles.  Managed using
[dotfiles](https://github.com/jbernard/dotfiles).

## Installation bits

### Necessary for dotfiles

    sudo apt-get install vim vim-gtk git tig git-gui git-svn gitk python-pip \
    xmonad suckless-tools xmobar dwm dmenu ubuntu-restricted-extras rxvt-unicode tmux \
    byobu terminator emacs trayer libghc6-xmonad-contrib-dev scrot cabal-install

### Cabal for yeganesh 

    cabal update
    cabal install yeganesh

### Dotfiles

    sudo pip install dotfiles
    mkdir -p ~/devel/lib/dotfiles
    git clone https://github.com/mjcarroll/dotfiles ~/devel/lib/dotfiles
    dotfiles -s -R ~/devel/lib/dotfiles

### Bumblebee
    sudo add-apt-repository ppa:bumblebee/stable
    sudo add-apt-repository ppa:ubuntu-x-swat/x-updates
    sudo apt-get update
    sudo apt-get install bumblebee bumblebee-nvidia linux-headers-generic


### ROS
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
    wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
