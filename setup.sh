rm -r ~/.bashrc ~/.vimrc ~/.config/i3 ~/.config/nvim ~/.config/kitty ~/.vim ~/.rgrc ~/.i3status.conf

# rc files
ln -s ~/zach_stuff/dotfiles/dotfiles/bashrc ~/.bashrc
ln -s ~/zach_stuff/dotfiles/dotfiles/vimrc ~/.vimrc

# i3
ln -s ~/zach_stuff/dotfiles/dotfiles/config/i3 ~/.config/i3
ln -s ~/zach_stuff/dotfiles/dotfiles/i3status.conf ~/.i3status.conf

# kitty
ln -s ~/zach_stuff/dotfiles/dotfiles/config/kitty ~/.config/kitty

# vim
ln -s ~/zach_stuff/dotfiles/dotfiles/config/nvim ~/.config/
ln -s ~/zach_stuff/dotfiles/dotfiles/config/nvim ~/.vim

# ripgrep
ln -s ~/zach_stuff/dotfiles/dotfiles/ripgreprc ~/.rgrc
