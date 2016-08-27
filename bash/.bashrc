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
# Go to Bookmark
whiz () {
    local bookmark_name="$1"
    if [ "$bookmark_name" == "help" ]; then
        zmansynopsis whiz
    elif [ -n "$bookmark_name" ]; then
        local bookmark_line=$(grep "$bookmark_name " ~/.NERDTreeBookmarks)
        local destination=${bookmark_line/$bookmark_name \~//Users/zacharytaira}
        local final_destination=${destination/$bookmark_name /}
        echo "Whizzing to $final_destination"
        cd $final_destination
    else
        echo ""
        echo "Here are the bookmarks you can currently whiz to:"
        nyan ~/.NERDTreeBookmarks 20
        echo ""
    fi
}

# Add Bookmark
whizadd () {
    local full_path=$PWD
    local bookmark_name="$1"
    if [ -n "$bookmark_name" ]; then
        echo "$bookmark_name ${full_path/$HOME/~}" >> ~/.NERDTreeBookmarks
    else
        zmansynopsis whizadd
    fi
}

# Read in lines and space them. 
# It's a spaced version of cat. 
nyan () {
    local filename="$1"
    local column_width="$2"
    while read -r line
    do
        local first_word=$(echo $line | sed -e 's/ .*//')
        local amount_of_spaces=$(($column_width-${#first_word}))
        local spaces=$(printf "%0.s." $(seq 1 $amount_of_spaces))
        echo $(printf '%s' "$line" | sed -e "s/ /$spaces/")
    done < "$filename"
}

# ============================================================================
# Code Snip Function - frag (frag, as in "only use the fragments you want")
# ============================================================================
# function that snips code fragments
frag () {
    local filename="$1"
    if [ -n "$filename" ]; then
        if [ -n "$2" ]; then
            echo '' > frag.txt
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
    else
        zmansynopsis frag
    fi
}

# ============================================================================
# Todo List Functions - todo (todo, as in "todo list")
# ============================================================================
# table created with:
# sqlite3 ~/todolist.db "create table data (id INTEGER PRIMARY KEY, name TEXT, start TEXT, end TEXT, notes TEXT, parent TEXT)"
# todo() prints out tasks
todo() {
    if [ "$1" == "" ]; then
        sqlite3 ~/todolist.db "select * from data where end=''" | todoprint
    elif [ "$1" == "all" ]; then
        sqlite3 ~/todolist.db "select * from data" | todoprint
    elif [ "$1" == "done" ]; then
        sqlite3 ~/todolist.db "select * from data where end!=''" | todoprint
    elif [ "$1" == "help" ]; then
        cat << EOF
Functions:
    todo............display the todo list
                    usage: todo [all] [done] [help]
    todochange......change an existing row
                    usage: todochange task_id col_name col_value
    todocomplete....complete a task
                    usage: todocomplete task_id [end_date]
    todonew.........create a new task
                    usage: todonew [-na name] [-s start] [-e end] [-no notes]
                                   [-p parent]
    todoprint.......format sqlite3 commands
                    usage: (sqlite_command) | todoprint
EOF
    fi
}

# todochange() changes a task
todochange() {
    local task_id="$1"
    local col_name="$2"
    local col_value="$3"
    if [ -n "$col_value" ]; then
        sqlite3 ~/todolist.db "update data set \"$col_name\"=\"$col_value\" \
            where id=\"$task_id\";"
        echo "Task Updated! :D"
    else
        zmansynopsis todochange
    fi
}

# autocompletes a task with the current or provided date
todocomplete() {
    local task_id="$1"
    local task_end="$2"
    local end_date=`date +"%Y-%m-%d"`
    if [ -n "$task_end" ]; then
        end_date="$task_end"
    fi
    if [ -n "$task_id" ]; then
        todochange "$task_id" "end" "$end_date"
    else
        zmansynopsis todocomplete
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
            -na|-name)
            task_name="$2"
            task_create="1"
            ;;
            -s|-start)
            task_start="$2"
            task_create="1"
            ;;
            -e|-end)
            task_end="$2"
            task_create="1"
            ;;
            -no|-notes)
            task_notes="$2"
            task_create="1"
            ;;
            -p|-parent)
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
    if [ -n "$task_create" ]; then
        if [ "$task_start" == '' ]; then
            task_start=`date +"%Y-%m-%d"`
        fi
        sqlite3 ~/todolist.db "insert into data ('name', 'start', 'end', 'notes', 'parent') \
            values (\"$task_name\", \"$task_start\", \"$task_end\", \"$task_notes\", \"$task_parent\");"
        echo "New task created! :D"
    else
        zmansynopsis todonew
    fi
}

# todoprint formats the output of an sqlite3 command
todoprint() { 
    read line
    local task_id=''
    local task_name=''
    local task_start=''
    local task_end=''
    local task_notes=''
    local task_parent=''
    local temp_name=''
    local temp_notes=''
    local bar='-----|----------------------|------------|------------|------->'
    echo "==================================================================>>"
    echo " ID  | Name                 | Start      | End        | Notes"
    echo "==================================================================>>"
    while [ -n "$line" ]
    do
        task_id=$(echo "$line" | sed -e 's/\(.*\)|.*|.*|.*|.*|.*/\1/')
        task_name=$(echo "$line" | sed -e 's/.*|\(.*\)|.*|.*|.*|.*/\1/')
        task_start=$(echo "$line" | sed -e 's/.*|.*|\(.*\)|.*|.*|.*/\1/')
        task_end=$(echo "$line" | sed -e 's/.*|.*|.*|\(.*\)|.*|.*/\1/')
        task_notes=$(echo "$line" | sed -e 's/.*|.*|.*|.*|\(.*\)|.*/\1/')
        task_parent=$(echo "$line" | sed -e 's/.*|.*|.*|.*|.*|\(.*\)/\1/')
        # echo $task_id
        # echo $task_name
        # echo $task_start
        # echo $task_end
        # echo $task_notes
        while [ -n "$task_name$task_notes" ]
        do
            temp_name="${task_name:0:20}"
            temp_notes="${task_notes:0:20}"
            printf "%-4s | %-20s | %-10s | %-10s | %-10s\n" "$task_id" \
                    "$temp_name" "$task_start" "$task_end" "$temp_notes"
            task_id=''
            task_name="${task_name:20}"
            task_start=''
            task_end=''
            task_notes="${task_notes:20}"
        done
        echo "$bar"
        read line
    done
}

# ============================================================================
# Documentation Function - zman (zman, as in "Zach's version of man")
# ============================================================================
# function that prints out a zman function entry
zman() {
    local man_file="/Users/zacharytaira/zman.md"
    local print_line=""
    local func_to_search="$1"
    if [ -n "$func_to_search" ]; then
        OLD_IFS="$IFS"
        IFS=''
        while read line
        do
            if [ "$line" == "### $func_to_search" ]; then
                print_line='1'
            elif [ "$line" == "end$func_to_search" ]; then
                print_line=''
            fi
            if [ -n "$print_line" ]; then
                echo "$line"
            fi
        done < "$man_file"
        IFS="$OLD_IFS"
    else
        zmansynopsis zman
    fi
}

zmansynopsis() {
    local man_file="/Users/zacharytaira/zman.md"
    local is_synopsis=""
    local in_function=""
    local func_to_search="$1"
    if [ -n "$func_to_search" ]; then
        OLD_IFS="$IFS"
        IFS=''
        while read line
        do
            if [ "$line" == "### $func_to_search" ]; then
                in_function='1'
            elif [ "$line" == "end$func_to_search" ]; then
                in_function=''
            fi
            if [ "$line" == "SYNOPSIS" ]; then
                is_synopsis='1'
            elif [ "$line" == "DESCRIPTION" ]; then
                is_synopsis=''
            fi
            if [ -n "$in_function" ]; then
                if [ -n "$is_synopsis" ]; then
                    echo "$line"
                fi
            fi
        done < "$man_file"
        IFS="$OLD_IFS"
    else
        zmansynopsis zmansynopsis
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

