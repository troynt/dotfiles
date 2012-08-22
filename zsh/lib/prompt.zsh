autoload -U colors
colors

setopt PROMPT_SUBST
bindkey -e

stty erase ˆH

REPORTTIME=10
LISTMAX=0

PS1="%n@%m:%~%# "

function machine_name {
    [ -f ~/.machine_name ] && cat ~/.machine_name || hostname -s
}

function number_of_jobs {
    count=$(jobs | wc -l | tr -d ' ') || return
    if [[ $count -eq 0 ]]; then
       return; 
    fi
    echo -n "[${count}] "
}

function git_prompt_unpushed {
    git cherry -v origin/$(git_prompt_branch) 2>/dev/null
}

function git_prompt_branch {
    echo -n $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function git_prompt_current_ref {
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    echo -n "${ref}"
}

function git_prompt_dirty {
    what=$(git status 2>/dev/null | tail -n 1)
    if [[ $what == '' ]]
    then
        echo ''
    else
        if [[ $what == 'nothing to commit (working directory clean)' ]]
        then
            echo "%{$fg[green]%}$(git_prompt_branch)%{$reset_color%}:"
        else
            echo "%{$fg[yellow]%}$(git_prompt_branch)%{$reset_color%}:"
        fi
    fi
}

PROMPT=$'$(number_of_jobs)$ '
RPROMPT='$(git_prompt_dirty)%{$reset_color%}%{$fg[cyan]%}%c%{$reset_color%}'
