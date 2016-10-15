# sbt commands
alias sc='sbt "~compile"'
alias stc='sbt "~test:compile"'
function st {
    while true; do
        if [[ -z $@ ]]; then
            sbt test
        else
            sbt "test-only $*"
        fi
        read
    done
}
function sr { sbt "run $@" }
function srm { sbt "run-main $@" }
function sr- { sbt "~run $@" }
function srm- { sbt "~run-main $@" }

function sbtmuch {
    while true; do
        columns=$(tput cols)
        let "lines = $(tput lines) - 1"
        tail_lines=4
        let "head_lines = $lines - $tail_lines"
        echo "compiling..."
        sbt $1 | fold -s --width=$columns > compile.log
        clear
        log_lines=`wc -l compile.log | sed "s/ .*//"`
        if [[ $log_lines -gt $lines ]]; then
            head -$head_lines compile.log
            tail -$tail_lines compile.log
        else
            cat compile.log
        fi
        read
    done
}
alias stcmuch='sbtmuch test:compile'
alias scmuch='sbtmuch compile'

