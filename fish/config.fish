#set -Ux EDITOR nvim
#set -Ux GUI_EDITOR nvim
#set -Ux BROWSER /usr/bin/qutebrowser
#set -Ux TERMINAL /usr/bin/kitty
#set -Ux VISUAL nvim
#set -Ux XDG_CONFIG_HOME /home/odmar/.config
#set -Ux fish_greeting
set -Ux MSBuildSDKsPath /usr/share/dotnet/sdk/(dotnet --version)/Sdks
#
## wayland settings
#set -Ux QT_WAYLAND_DISABLE_WINDOWDECORATION 1
#set -Ux XDG_CURRENT_DESKTOP sway
#set -Ux XDG_SESSION_TYPE wayland
#set -Ux SDL_VIDEODRIVER x11
#
# aliases
alias cp="cp -uv"
alias cf="cp -ruv"
alias df="df -h"
alias free="free -m"
alias se="sudoedit"
alias ls="ls -A --color=always"
alias mkd="mkdir (date +"%Y_%m_%d")"
alias ocd="kitty (pwd)& echo ''"
alias ya="yarn global add"

# pcli aliases
alias po="pcli project open (pcli project list | fzf)"

alias asp-gen="dotnet-aspnet-codegenerator"
alias dr="dotnet run --runtime linux-x64"

alias gitu="git add . && git commit && git push"
alias ghc='gh repo clone (gh repo list | fzf | grep -oP "^[^.\t]*")'
alias ghr="gh repo create --source=. --remote=origin --source=. --add-readme --push --public"
alias ghrp="gh repo create --source=. --remote=origin --source=. --add-readme --push --private"
alias gitc="git checkout (git for-each-ref --format='%(refname:short)' refs/heads/ | fzf)"

alias v="nvim"
alias gv="nvim --listen ~/.cache/nvim/godot.pipe"
alias upd="paru -Syu --sudoloop"
alias q="exit"
alias pyi="pip install --user"
alias sch="slurp | grim -g - (xdg-user-dir Pictures)/(date
 + 'screenshot_%Y-%m-%d-%H%M%S.png')"

alias ydlm="yt-dlp -x --audio-format 'mp3'"
alias ydlv="yt-dlp -f 'betvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias edit="zk edit -i"

function gic --description "clone a repo arg is name of owner" 
    gh repo clone (gh repo list $argv | grep -Po "^[^.\t]*" | fzf)
end

function vrg --description "open files in nvim that matches a pattern" 
    nvim (rg --files-with-matches $argv)
end

function cdd --description "go to dir an show it"
    cd $argv && ls -a
end

function mk --description "make a dir an go to it"
    mkdir $argv && cd $argv
end

function rd --description "remove file or dir"
    if test -d $argv
        rm -rf $argv
    else 
        rm $argv
    end 
end

function rdi --description "remove file or dir interactively"
    if test -d $argv
        rm -rfi $argv
    else 
        rm -i $argv
    end
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

complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# start sway at login
if status is-login
    #if test -z "$DISPLAY" -a "$XDG_VNTR" = 1
    sh ~/.config/fish/startup.sh
    exec sway
    #end
end

