# ssh key management
function sadd {
    # if ssh-agent is not running in this terminal: start it
    if [[ -z $SSH_AGENT_PID ]]; then
        eval $(ssh-agent | head -2)
    fi

    # if only one parameter provided: use it as filename for the key
    if [[ -z $2 ]]; then
        if (ssh-add -l | cut -d \  -f 3 | grep $1 > /dev/null); then
            echo "key already loaded"
        else
            ssh-add $1
        fi
        # else use provided host and user name to generate a filename
    else
        if (ssh-add -l | cut -d \  -f 3 | grep $HOME/.ssh/id_rsa.$1.$2 > /dev/null); then
            echo "key already loaded"
        else
            ssh-add ~/.ssh/id_rsa.$1.$2
        fi
    fi
}

alias gadd='sadd ~/.ssh/id_rsa.github'
alias hadd='sadd heraklit guest'
