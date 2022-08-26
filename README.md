# Dotfiles

My local development dotfiles and configuration.

Initial configuration based on [thoughtbot/dotfiles].

[thoughtbot/dotfiles]: https://github.com/thoughtbot/dotfiles

## Installation

1. [Install homebrew]
1. [Install Rust]
1. Install [rcm]
    - `brew install rcm`
1. Clone the repository into `.dotfiles`
1. `rcup rcrc`
1. Install latest `python3` and `nodejs` LTS using asdf
    - `asdf plugin add python`
    - `asdf plugin add nodejs`
    - `rcup tool-versions`
    - `asdf install`
1. Install python3 and nodejs providers for neovim
    - See `:checkhealth provider` in `neovim`
    - `pip3 install --user --upgrade pynvim`
    - `npm install -g neovim`
1. Install brew bundle
    - `rcup Brewfile`
    - `brew bundle`
1. Symlink the rest of the dotfiles
    - `rcup -v`

[rcm]: https://github.com/thoughtbot/rcm
[Install Rust]: https://www.rust-lang.org/tools/install
[Install homebrew]: https://brew.sh
