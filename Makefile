DOTFILES_DIR=${HOME}/.dotfiles
TMUX_SHARE=${HOME}/.local/share/tmux

.PHONY: brew
brew:
	@brew update
	@echo "reading brewfile from: $(DOTFILES_DIR)/homebrew/Brewfile"
	@brew bundle --file="$(DOTFILES_DIR)/homebrew/Brewfile"

.PHONY: .ohmyzsh
ohmyzsh:
	@if [ ! -d ~/.oh-my-zsh ]; then git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &>/dev/null; fi

.PHONY: tmux
tmux:
	@if [ ! -d "$(TMUX_SHARE)/plugins/tpm" ]; then git clone https://github.com/tmux-plugins/tpm "$(TMUX_SHARE)/plugins/tpm"; fi
	@-tmux kill-server
	@tmux start-server
	@tmux new-session -d
	${HOME}/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh
	@tmux kill-server

.PHONY: stow
stow:
	@stow -v --stow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES_DIR)/files" tmux
	@stow -v --stow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES_DIR)/files" oh-my-posh
	@stow -v --stow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES_DIR)/files" --dotfiles git
	@stow -v --stow --ignore ".DS_Store" --target="$(HOME)/Library/Application Support/k9s" --dir="$(DOTFILES_DIR)/files" k9s

# TODO: gpg signature gitconfig
# TODO: zshrc
# TODO: aws-select
# TODO: Apple.Terminal allow mouse reporting by default
# TODO: set tmux as default command when opening terminal (`defaults` CLI: ~/Library/Preferences/com.apple.Terminal.plist)
# TODO: os keyboard shortcuts: launch Terminal, window toggling
# TODO: VSCode settings
# TODO: install fonts needed for powerline
