# dropbox-related commands
# list sync status of current dir
function lsd {
    dropbox-cli filestatus |\
        grep -v "^\." |\
        grep -v ":.*unwatched" |\
        sed -r "s/up to date/■/; s/syncing/□/; s/(.*): *([■□])/\2 \1/"
}

# dropbox is loading what?
function dbw {
    for x in $(find ~/Dropbox); do
        dropbox-cli filestatus ${(f)"$(print $x)"} | grep -v "up to date"
    done
}

alias dbs='dropbox-cli status'
alias dbstop='dropbox-cli stop'
alias dbstart='dropbox-cli start'
alias dbss='watch dropbox-cli status'
