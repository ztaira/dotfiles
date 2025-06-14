set -e

source_directory=$1
if [ -z ${source_directory} ]; then
  echo "Please provide an origin directory to copy files from! e.g."
  echo ""
  echo "  bash setup.sh /path/to/directory/with/configs"
  false
fi

#==========================================================
# Install tmux plugins
#==========================================================
rm -r ~/.tmux/plugins || true
mkdir -p ~/.tmux/plugins
git clone https://github.com/jaclu/tmux-menus ~/.tmux/plugins/tmux-menus

#==========================================================
# Install config files
#==========================================================
rm -r ~/.tmux.conf ~/.bashrc ~/.vimrc ~/.config/i3 ~/.config/nvim ~/.config/kitty ~/.vim ~/.rgrc ~/.i3status.conf || true
mkdir -p ~/.config

# rc files
ln -s ${source_directory}/bashrc ~/.bashrc
ln -s ${source_directory}/vimrc ~/.vimrc
ln -s ${source_directory}/tmux.conf ~/.tmux.conf

# i3
ln -s ${source_directory}/config/i3 ~/.config/i3
ln -s ${source_directory}/i3status.conf ~/.i3status.conf

# kitty
ln -s ${source_directory}/config/kitty ~/.config/kitty

# vim
ln -s ${source_directory}/config/nvim ~/.config/
ln -s ${source_directory}/config/nvim ~/.vim

# ripgrep
ln -s ${source_directory}/ripgreprc ~/.rgrc
set +e
