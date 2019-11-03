set -xg PATH $PATH "$HOME/Bin"
set -xg TEMPORARY "$HOME/Temporary"
set -xg INBOX "$HOME/Inbox"


# default folder for mates
# set -xg MATES_DIR ~/.kontakte
# mates binary is in .cargo/bin
# set -xg PATH $PATH $HOME/.cargo/bin


set fish_greeting


# Fixes strange output when Emacs runs Fish
# https://github.com/fish-shell/fish-shell/issues/1155#issuecomment-420962831
if ! test "$TERM" = "dumb"
    fish_vi_key_bindings
end


alias s='sudo'


alias ls='exa'
alias l='exa'
alias ll='exa -l'
alias la='ls -a'
alias lla='ll -a'
alias tree='exa --tree'
alias lld='du -h | grep \'\./[^/]\+$\' | sed -e "s/\(.*\)\.\/\(.*\)/\1\2/"'
function n --description='Echo newly created files'
  if test -z $argv; or test $argv = "t"
    echo $TEMPORARY/(command ls --sort time $TEMPORARY | head -1)
  else if test $argv[1] = "f"
    command ls --sort time (find -maxdepth 1 -type f \! -path './.*') | head -1
  else if test $argv[1] = "d"
    command ls --sort time (find -maxdepth 1 -type d \! -path './.*' \! -name '.') | head -1
  else if test -z $argv; or test $argv = "t"
    echo $INBOX/(command ls --sort time $TEMPORARY | head -1)
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
function mvc --wraps=mv --description='Create the destination directory, then move the files there'
  if test (count $argv) -gt 1
      mkdir -p $argv[-1]
      mv $argv
  else
      echo "Not enough arguments given"
  end
end


alias x='chmod +x'


alias df='dfc'


alias v='emacsclient -a emacs'
alias g='git'
alias led='ledger --strict --file /home/david/Buchhaltung/Gesamt.journal'
alias o='open'
alias ont='o (n t)'
alias onf='o (n f)'
alias oni='o (n i)'
alias mvt='mv (n t)'
alias mvi='mv (n i)'
alias mvf='mv (n f)'
alias mvd='mv (n d)'
alias mutt='neomutt'
# from `man feh`: Scale images to fit window geometry
alias feh='feh --scale-down --theme=default'
alias zz='z -l Temp | head -1 | awk \'{print $2}\''


function sortimgs
    set -l folder (mktemp -d -p .)
    feh --action "mv %n $folder" --action1 "mkdir TRASH; mv %n TRASH"
    command ls $folder
    read name
    mv $folder $name
end


alias m='udiskie-mount -ar'
alias um='udiskie-umount -a'
alias umoc='sudo umount -l /mnt/oc-h ; sudo umount -l /mnt/oc-m'
alias moc='sudo mount /mnt/oc-h ; sudo mount /mnt/oc-m'


alias tnat='nix-shell -p python3 --command "curl -fsSl https://raw.githubusercontent.com/tridactyl/tridactyl/master/native/install.sh | bash"'


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


alias cal='khal calendar -a Arbeit -a OC -a Ich -a Beide'
alias agenda='khal list -a Arbeit -a OC -a Ich -a Beide'
alias arbeit='khal new -a Arbeit'
alias ich='khal new -a Ich'
alias beide='khal new -a Beide'
alias urlaub='math 40 - (math (command ls /mnt/oc-m/Verwaltung/Urlaubsantraege/Pätzel/ | sed -E "s/.*_([[:digit:]]+)Tag.*/\1/" | paste -sd+))'


function texr
    entr fish -c "latexmk $argv ; fixfonts out/*.pdf"
end


function sources
    if test -z "$argv"
        echo *.tex
        cat *.tex | grep -E '\\\\input{' | sed -E 's/.*\\\\input\{(.*)\}.*/\1.tex/'
    else
        echo $argv
        cat $argv | grep -E '\\\\input{' | sed -E 's/.*\\\\input\{(.*)\}.*/\1.tex/'
    end
end


function hearthstone
    set -x WINEPREFIX "$HOME/Spiele/Hearthstone"
    wine "C:/Program Files/Battle.net/Battle.net Launcher.exe"
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


function ord
    echo "$argv" | od -A n -t d1 | read -l addr num ;and echo $addr
end


function chr
    printf "%b\n" '\0'(printf '%o\n' "$argv")
end


function lit
    if test "$argv[1]" != "" -a "$argv[2]" != "" -a "$argv[3]" != "" -a "$argv[4]" != ""
        set -l num
        if test "$argv[5]" = ""
            set num ""
        else
            set num "$argv[5]"
        end

        set -l pdf "$argv[1]"
        set -l author "$argv[2]"
        set -l year "$argv[3]"
        set -l title "$argv[4]"

        set -l short "$author$year"
        set -l long "$year $title"

        if test -d "$HOME/Literatur/$short$num"
            if test "$num" = ""
                lit "$pdf" "$author" "$year" "$title" "b"
            else
                lit "$pdf" "$author" "$year" "$title" (chr (math (ord "$num") + 1))
            end
        else
            echo "Creating Literatur/$short$num"
            mkdir "$HOME/Literatur/$short$num"
            mv "$pdf" "$HOME/Literatur/$short$num/$long.pdf"
            echo "* 1 $short$num" >> "$HOME/Literatur/$short$num/$short$num.org"
        end
    end
end


function bib
    if test "$argv[1]" != "" -a "$argv[2]" != ""
        set -l file "$argv[1]"
        set -l name "$argv[2]"

        v "$file"
        cp "$file" "$HOME/Literatur/$name/$name.bib"
        rm "$file"
    end
end


function allpass
    for f in (find ~/.password-store/ -type f -iname '*.gpg' | sed -r 's/^.*store\///;s/.gpg$//')
        set -l IFS
        set content (pass "$f")
        set pw (echo "$content" | head -1)
        echo "$f: $pw"
    end
end


function checkpass
    for f in (find ~/.password-store/ -type f -iname '*.gpg' | sed -r 's/^.*store\///;s/.gpg$//')
        set -l IFS
        set content (pass "$f")
        set pw (echo "$content" | head -1)
        if test (string length -- "$pw") -lt 25
            if test (echo "$content" | tail -1) != "Regeln"
              echo "$f: $pw"
            end
        end
    end
end


function mkmail
    mkdir -p "$argv"/{cur,new,tmp}
end


alias cinit="\
cabal init \
  --cabal-version=2.2 \
  --dependency=\"base ^>=4.12.0.0\" \
  --dependency=protolude \
  --dependency=QuickCheck \
  --source-dir=src \
  --category=\"\" \
  --homepage=\"\" \
  --synopsis=\"\" \
  --language=Haskell2010 \
  --main-is=src/Main.hs \
  --license=\"GPL-3\" \
  --no-comments"


alias update-spacemacs="\
cd ~/.emacs.d && \
  git pull --rebase; \
  find ~/.emacs.d/elpa/2*/develop/org-plus-contrib* -name '*.elc' -delete"


function gong
    date
    for t in $argv
      sleep $t
      mpv "$HOME/.Gong.mp3" &
    end
end
