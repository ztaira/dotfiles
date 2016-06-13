#!/bin/bash

# ============================================================================
# Environment Settings
# ============================================================================
alias ls="ls -Gh"
alias la="ls -laG"

# ============================================================================
# Bookmark Functions - whiz (whiz, as in "whiz to $bookmarkname")
# ============================================================================
# Add Bookmark
whizadd () {
    full_path=$PWD
    echo "$1 ${full_path/$HOME/~}" >> ~/.NERDTreeBookmarks
}

# Go to Bookmark
whiz () {
    if [ "$1" != "" ]; then
        bookmark_line=$(grep "$1 " ~/.NERDTreeBookmarks)
        destination=${bookmark_line/$1 \~//Users/ztiara}
        final_destination=${destination/$1 /}
        echo "Whizzing to $final_destination"
        cd $final_destination
    else
        echo ""
        echo "Here are the bookmarks you can currently whiz to:"
        nyan ~/.NERDTreeBookmarks 20
        echo ""
    fi
}

# Read in lines and space them. 
# It's a spaced version of cat. 
nyan () {
    filename="$1"
    columnn_width="$2"
    while read -r line
    do
        first_word=$(echo $line | sed -e 's/ .*//')
        amount_of_spaces=$(($2-${#first_word}))
        spaces=$(printf "%0.s." $(seq 1 $amount_of_spaces))
        echo $(printf '%s' "$line" | sed -e "s/ /$spaces/")
    done < "$filename"
}

# ============================================================================
# Code Snip Function - frag (frag, as in "only use the fragments you want")
# ============================================================================
frag () {
    filename="$1"
    echo '' > frag.txt
    if [ "$2" != "" ]; then
        for arg in "$@"
        do
            if [ "$arg" != "$1" ]; then
                first_number=$(echo $arg | sed -e 's/\.\..*//')
                second_number=$(echo $arg | sed -e 's/.*\.\.//')
                for line in `seq $first_number $second_number`
                do
                    sed "${line}q;d" $filename >> frag.txt
                done
            fi
        done
    else
        cat -n $1
    fi
}

# ============================================================================
# tmux
# ============================================================================
# sessions
csession ()  {
    tmux choose-session
}

lsessions () {
    tmux list-sessions
}

nsession () {
    tmux new -s $1
}

asession () {
    tmux attach-session -t $1
}

detach () {
    tmux detach
}

# panes
vsplit () {
    tmux split-window -h
}

hsplit () {
    tmux split-window
}

zoom () {
    tmux resize-pane -Z
}

up () {
    tmux select-pane -U
}

down () {
    tmux select-pane -D
}

left () {
    tmux select-pane -L 
}

right () {
    tmux select-pane -R
}

dpanes () {
    tmux display-panes
}

swpanes () {
    tmux swap-pane -s $1 -t $2
}

# misc
lcommands () {
    tmux list-commands
}

