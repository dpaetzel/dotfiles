# xdg-mime stuff
function which-app {
    mimetype=`xdg-mime query filetype $1`
    application=`xdg-mime query default $mimetype | sed -r 's/\.desktop//'`
    printf "$mimetype: $application\n"
}
alias set-app='xdg-mime default'
