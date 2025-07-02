# Start X at login
if status --is-login
    if test (tty) = /dev/tty1
        exec startx -- -keeptty
    end
end
set fish_greeting
zoxide init fish | source


# set -U fish_color_command 'blue'
set -U fish_color_command blue
set -U fish_color_command_current cyan
set -U fish_color_autosuggestion brblack
function fish_user_key_bindings
  fish_vi_key_bindings
end

# Paths
set -gx fish_user_paths ~/.local/scripts  ~/.local/bin ~/go/bin ~/.cargo/bin /opt/flutter/bin ~/.pub-cache/bin $fish_user_paths /opt/homebrew/bin ~/snap/bin /usr/local/go/bin/bin/

set -gx SUDO_EDITOR nvim
set -gx GOPATH /usr/local/go/bin
# set -gx JAVA_HOME /usr
# Alias
alias gcc="/usr/bin/gcc"
alias g++="/usr/bin/g++"
alias py="python3"
alias vim="nvim"
alias vi="nvim"
alias c="clear"
alias top="htop"
alias po="poetry"
alias q="exit"
alias dc="docker-compose"
alias dk="docker"
alias gs="git status"
alias lg="lazygit"
alias gch="git checkout"
alias ls="exa"
alias la="exa -la"
alias sync='osync.sh ~/.config/osync/sync.conf'
# alias yay="paru --color always"
alias du="du -h"
alias tmux="TERM=screen-256color-bce /usr/bin/tmux"
alias rm="trash"
alias space="dust -d 2"
alias tma="tmux attach -t"
alias python="python3"
alias gputop="nvtop"
alias gclit="gcli crawler test -s"
alias fd='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
#alias mirror="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 -r 120.00 --rotate normal --output DP-3 --mode 1920x1080 --same-as eDP-1 -r 60.00 --rotate normal"
# Disable ENV prompt since it is already shown on the right side
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -gx DBUS_SESSION_BUS_ADDRESS 'unix:path=/run/user/1000/bus'
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda/lib64
set -gx LANG en_US.UTF-8
set -Ux PYENV_ROOT $HOME/.pyenv
set -gx _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on'
set -gx JAVA_FONTS /usr/share/fonts/TTF

if test -z "$XDG_CURRENT_DESKTOP"
    set -Ux XDG_CURRENT_DESKTOP GNOME
end

if test -z "$QT_QPA_PLATFORMTHEME"
   set -Ux QT_QPA_PLATFORMTHEME qt5ct
end


atuin init fish | source > /dev/null 2>&1
# pyenv init - | source > /dev/null 2>&1
# sven export --shell fish | source > /dev/null 2>&1

# source /usr/share/nvm/nvm.sh
# source /usr/share/nvm/bash_completion
# source /usr/share/nvm/install-nvm-exec
# source /usr/share/nvm/init-nvm.sh
# pyenv init - fish | source
# atuin init fish | source
# sven export --shell fish | source

set -x PKG_CONFIG_PATH /usr/local/lib/pkgconfig $PKG_CONFIG_PATH

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/avgt/.lmstudio/bin
set -gx DISPLAY :0
