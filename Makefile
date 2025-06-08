# Variables for installation paths
prefix ?= /etc
DESTDIR ?=
install_dir := $(DESTDIR)$(prefix)/zt-dotfiles

# List of files and directories to install
files := $(wildcard *)
exclude := Makefile setup.sh
install_files = dotfiles/bashrc dotfiles/vimrc dotfiles/i3status.conf dotfiles/ripgreprc dotfiles/tmux.conf dotfiles/setup.sh
install_dirs = dotfiles/config/i3 dotfiles/config/kitty dotfiles/config/nvim

.PHONY: help docs
# Put it first so that "make" without argument is like "make help"
# God bless the interwebs:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## List Makefile targets
	$(info Makefile documentation)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

install: ## Install target
	@echo "Installing files to $(install_dir)..."
	install -d $(install_dir)/dotfiles/config
	for file in $(install_files); do \
		echo $$file; \
		install $$file $(install_dir)/$$file; \
	done
	for directory in $(install_dirs); do \
		echo $$directory; \
		cp -r $$directory $(install_dir)/dotfiles/config/; \
	done
	@echo "Installation complete."
