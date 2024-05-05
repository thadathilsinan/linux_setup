if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    eval "$(starship init fish)"
    set PS1 '[\u@\h \W]\$ '

    export PATH="/usr/lib/ccache/bin/:$PATH"
    cat ~/.cache/wal/sequences
    pfetch
end
