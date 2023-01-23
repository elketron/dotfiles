set -U EDITOR /usr/bin/nvim
set -U GUI_EDITOR /usr/bin/nvim
set -U BROWSER /usr/bin/qutebrowser
set -U TERMINAL /usr/bin/kitty
set -U VISUAL /usr/bin/nvim
set -U XDG_CONFIG_HOME /home/odmar/.config
set -U fish_greeting
set -U MSBuildSDKsPath /usr/share/dotnet/sdk/(dotnet --version)/Sdks

# wayland settings
set -U QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -U XDG_CURRENT_DESKTOP sway
set -U XDG_SESSION_TYPE wayland
set -U SDL_VIDEODRIVER x11

# aliases
alias cp="cp -uv"
alias cf="cp -ruv"
alias df="df -h"
alias free="free -m"
alias gitu="git add . && git commit && git push"
alias se="sudoedit"
alias ls="ls -A --color=always"
alias mkd="mkdir (date +"%Y_%m_%d")"
alias ocd="kitty (pwd)"

alias v="nvim"
alias upd="paru -Syu --sudoloop"
alias q="exit"
alias pyi="pip install --user"

alias ydlm="yt-dlp -x --audio-format 'mp3'"
alias ydlv="yt-dlp -f 'betvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"

function gic --description "clone a repo arg is name of owner" 
    gh repo clone (gh repo list $argv | grep -Po "([a-zA-Z\.\d_-]+/[a-zA-Z\.\d_-]+)" | fzf)
end

function cdd --description "go to dir an show it"
    cd $argv && ls -a
end

function mk --description "make a dir an go to it"
    mkdir $argv && cd $argv
end

function ydlp --description "download a playlist"
    yt-dlp $argv -o 'Videos/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'
end

function zf --description "zip a folder"
    zip -r $argv $argv.zip
end

function fish_prompt
    echo -n (set_color -o blue)"[" 
    echo -n (set_color normal)(prompt_pwd) 
    echo -n (set_color -o blue)"]: "(set_color normal)
end
    
function fish_right_prompt
    set_color red
    echo -n (fish_git_prompt)
    set_color normal
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# start sway at login
if status is-login
    #if test -z "$DISPLAY" -a "$XDG_VNTR" = 1
    exec sway
    #end
end

