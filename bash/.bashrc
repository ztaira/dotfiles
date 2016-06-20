#!/bin/bash

# ============================================================================
# Environment Settings
# ============================================================================
alias ls="ls -Gh"
alias la="ls -laG"
set -o vi

# ============================================================================
# Bookmark Functions - whiz (whiz, as in "whiz to $bookmarkname")
# ============================================================================
# Add Bookmark
whizadd () {
    local full_path=$PWD
    echo "$1 ${full_path/$HOME/~}" >> ~/.NERDTreeBookmarks
}

# Go to Bookmark
whiz () {
    if [ "$1" != "" ]; then
        local bookmark_line=$(grep "$1 " ~/.NERDTreeBookmarks)
        local destination=${bookmark_line/$1 \~//Users/ztiara}
        local final_destination=${destination/$1 /}
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
    local filename="$1"
    local columnn_width="$2"
    while read -r line
    do
        local first_word=$(echo $line | sed -e 's/ .*//')
        local amount_of_spaces=$(($2-${#first_word}))
        local spaces=$(printf "%0.s." $(seq 1 $amount_of_spaces))
        echo $(printf '%s' "$line" | sed -e "s/ /$spaces/")
    done < "$filename"
}

# ============================================================================
# Code Snip Function - frag (frag, as in "only use the fragments you want")
# ============================================================================
frag () {
    local filename="$1"
    echo '' > frag.txt
    if [ "$2" != "" ]; then
        for arg in "$@"
        do
            if [ "$arg" != "$1" ]; then
                local first_number=$(echo $arg | sed -e 's/\.\..*//')
                local second_number=$(echo $arg | sed -e 's/.*\.\.//')
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
# Todo List Functions - todo (todo, as in "todo list")
# ============================================================================
# table created with:
# sqlite3 todolist.db "create table data (id INTEGER PRIMARY KEY, name TEXT, start TEXT, end TEXT, notes TEXT, parent TEXT)"
# todo() prints out tasks
todo() {
    if [ "$1" == "" ]; then
        sqlite3 todolist.db "select * from data where end=''"
    elif [ "$1" == "all" ]; then
        sqlite3 todolist.db "select * from data"
    fi
}

# todonew creates a new task
todonew() {
    # set all the tasks columns to zero
    local task_name=""
    local task_start=""
    local task_end=""
    local task_notes=""
    local task_parent=""
    # whether or not to create a new task
    local task_create=""
    # while the number of arguments is greater than 1
    # fill in the column arguments
    # then shift the arguments over twice
    while [[ $# -gt 1 ]]
    do
        key="$1"
        case $key in
            -name)
            task_name="$2"
            task_create="1"
            ;;
            -start)
            task_start="$2"
            task_create="1"
            ;;
            -end)
            task_end="$2"
            task_create="1"
            ;;
            -notes)
            task_notes="$2"
            task_create="1"
            ;;
            -parent)
            task_parent="$2"
            task_create="1"
            ;;
            *)
            # just in case something wonky comes in
            ;;
        esac
        shift
        shift
    done
    if [ "$task_create" != "" ]; then
        sqlite3 todolist.db "insert into data ('name', 'start', 'end', 'notes', 'parent') \
            values (\"$task_name\", \"$task_start\", \"$task_end\", \"$task_notes\", \"$task_parent\");"
        echo "New task created! :D"
    else
        echo "Table Columns:"
        echo "| id | name | start | end | notes | parent |"
    fi
}

# todochange
todochange() {
    local task_id="$1"
    local col_name="$2"
    local col_value="$3"
    sqlite3 todolist.db "update data set \"$col_name\"=\"$col_value\" \
        where id=\"$task_id\";"
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

