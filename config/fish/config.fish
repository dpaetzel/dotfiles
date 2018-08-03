fish_vi_key_bindings


set -xg PATH $PATH $HOME/Bin
set -xg TEMPORARY $HOME/Temporary




alias s='sudo'


alias ls='ls --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias lla='ls -alFh'
alias lld='du -h | grep \'\./[^/]\+$\' | sed -e "s/\(.*\)\.\/\(.*\)/\1\2/"'
function n --description='Echo newly created files'
  if test -z $argv; or test $argv = "t"
    echo $TEMPORARY/(ls --sort time $TEMPORARY | head -1)
  else if test $argv[1] = "f"
    ls --sort time (find -maxdepth 1 -type f \! -path './.*') | head -1
  else if test $argv[1] = "d"
    ls --sort time (find -maxdepth 1 -type d \! -path './.*' \! -name '.') | head -1
  end
end


function rm --wraps=rm --description='Delete using trash directory'
  if test (count $argv) -gt 0
    set -l trash_dir "$HOME/.TRASH"
    for file in $argv
      if test -e $file
        set -l file_name (basename $file)
        if test -e "$trash_dir/$file_name"
          set -l current_time (date "+%s")
          command mv -f "$trash_dir/$file_name" "$trash_dir/$file_name $current_time"
        end
        command mv -f "$file" "$trash_dir/"
      else
        echo "No such file: $file"
      end
    end
  else
    echo "No arguments given"
  end
end
alias rmr='command rm -rv'
alias cp='cp -v'
alias mv='mv -v'


alias x='chmod +x'


alias df='dfc'


alias v='emacsclient -a emacs'
alias g='git'
alias o='open'
alias ont='o (n t)'
alias onf='o (n f)'
alias of='o (fzf)'
alias mutt='neomutt'
# from `man feh`: Scale images to fit window geometry
alias feh='feh --scale-down --theme=default'


function sortimgs
    set -l folder (mktemp -d -p .)
    feh --action "mv %n $folder" --action1 "mkdir TRASH; mv %n TRASH"
    ls $folder
    read name
    mv $folder $name
end


alias m='udiskie-mount -ar'
alias um='udiskie-umount -a'


# not beautiful but works(?)
function vpn
    set name $1

    nm-applet ^ /dev/null &
    set pid %1

    sleep 2

    nmcli con up {$name}-vpn

    begin
        sleep 10
        kill $pid
    end ^ /dev/null &
end


# alias plotting='nix-shell -p gnuplot haskellPackages.cassava haskellPackages.gnuplot ghc'
alias plotting='nix-shell -p "haskellPackages.ghcWithPackages (pkgs : [ pkgs.cassava pkgs.easyplot ])" gnuplot'
alias plottingNoEasy='nix-shell -p "haskellPackages.ghcWithPackages (pkgs : [ pkgs.cassava ])" gnuplot'


alias agenda='khal list -a Arbeit -a OC -a Ich -a Beide'


function hearthstone
    set -x WINEPREFIX "$HOME/Spiele/Hearthstone"
    wine "C:/Program Files/Battle.net/Battle.net Launcher.exe"
end


function texr
    set createCmd 'latexmk -interaction=nonstopmode *.tex'

    rm out
    ls | entr fish -c "$createCmd ; fixfonts out/*.pdf"
    eval $createCmd ; fixfonts out/*.pdf
end


function qt
    # if test $argv[1] = "--system"
    #     set -l PATH (echo $PATH | sed 's#/home/david/.nix-profile/bin ##')
    # else if test $argv[1] = "--user"
    #     set -l PATH (echo $PATH | sed 's#/run/current-system/sw/bin ##')
    # else
    #     echo "Either use --system or --user parameter"
    set -l p $PATH
    echo $argv[1]
    echo $argv[2]
    if test $argv[1] = "--system"
        set PATH /run/current-system/sw/bin
    else if test $argv[1] = "--user"
        set PATH home/david/.nix-profile/bin
    else
        echo "Either use --system or --user parameter"
    end

    eval $argv[2]

    set PATH $p
end

