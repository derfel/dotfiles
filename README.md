# dotfiles

My dotfiles.
Some parts of this readme has been copied from https://github.com/adoyle-h/dotfiles.

## Dependencies

- [git][]: **It is required**. Make sure it available before installation.
  - [git-prompt][]: If omitted, PS1 will not show git prompt.
- [dotbot][]: To create symbolic links and manage the map via [`install.conf.yaml`][install.conf.yaml]. There is no need to install dotbot manually. It is a part of this repo.
- [bash-it (modified version)][a-bash-it]: To manage all shell scripts in modules: aliases, plugins, completions and shell appearance theme. **It is required**. Make sure it available before installation.


## Installation

```sh
# Clone this repo
DOTFILE_DIR=~/.dotfiles
git clone --depth 1 --recursive https://github.com/derfel/dotfiles.git $DOTFILE_DIR
# Install bash_it framework which is required
git clone --depth 1 https://github.com/adoyle-h/bash-it ~/.bash_it
~/.bash_it/install.sh --no-modify-config
${DOTFILE_DIR}/bash_it/reset.sh
./install
# checkout the output
```

And then read the [Configuration - Modifications by yourself](#modifications-by-yourself) section.

## Configuration

### Modifications by yourself

These parts of below files you should modify:

./configs/gitconfig:

```
[user]
    name = <your-username>
    email = <your-email>
```

