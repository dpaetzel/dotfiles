# file operations
alias ls='ls --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias lla='ls -alFh'
alias lld='du -h | grep "\./[^/]\+$" | sed -e "s/\(.*\)\.\/\(.*\)/\1\2/"'

alias df='dfc'
alias f='find . -name'

alias rm='mv -v --target-directory=$HOME/.TRASH'
alias rmr='command rm -rfv'

alias cp='cp -v'
alias mv='mv -v'
alias mmv='noglob zmv'

alias x='chmod +x'

function getimgs {
    folder=img-`date -I`
    mkdir $folder
    cd $folder
    adb pull storage/sdcard1/DCIM/Camera
}

function sortimgs {
    local folder=$(mktemp -d -p .)
    feh --action "mv %n $folder" --action1 "mkdir TRASH; mv %n TRASH"
    ls $folder
    read name
    mv $folder $name
}
