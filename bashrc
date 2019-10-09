#!/bin/bash
setxkbmap -option caps:escape # linux: map caps to escape
source ~/.cargo/env
export PATH=$PATH:~/.local/bin # add .local/bin to path
export HISTSIZE="" # linux: infinite history
source ~/.bash_secrets

# ============================================================================
# Environment Settings
# ============================================================================
# git stuff
alias ls="ls --color"
alias la="ls -laFG --color"
alias gl="git log --graph"
alias gh="git log --pretty=format:'%C(yellow)%h%Creset %ad %C(yellow)|%Creset %s%C(bold blue)%d%Creset %C(red)[%an]%Creset' --graph --date=short"
alias gs="git status"
alias ga="git add"
alias gb="git branch"
alias gp="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gcf="git commit --fixup HEAD"
alias gdc="git diff --cached"
alias gdn="git diff --name-only"
alias gdfm="git diff origin/master"
alias gdnfm="git diff --name-only origin/master"
alias gdcn="git diff --cached --name-only"
alias gst="git stash"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gri="git rebase -i"
alias cmake="/Applications/CMake.app/Contents/bin/cmake"

# ----------------------------------------------------------------------------
# Quality-of-life stuff
# ----------------------------------------------------------------------------
# Run matlab without having to boot the app
alias matlab='/Applications/MATLAB_R2014b.app/bin/matlab -nodesktop'
set -o vi

# Change volume via the terminal
alias vol="alsamixer" # linux: get a TUI for volume
# Use nvim for vi
alias vi="nvim"
# Open
alias win="xdg-open ." # linux: open a new window
alias open="xdg-open" # linux: open a thing
# Copy
alias pbcopy="xclip" # linux: imitate pbcopy on mac
alias pbpaste="xclip -o" # linux: imitate pbcopy on mac
# ping
alias p8="ping 8.8.8.8"
# history, but pipe through grep
alias hg="history | grep"
# adjust brightness on linux
alias xbr="xrandr --output eDP-1 --brightness"
# ps
alias psef="ps -ef"
alias psefg="ps -ef | grep"
# find to grep
alias fpg="find | grep"
# colored ls output
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
# run python in environment
alias prp="pipenv run python"

# ----------------------------------------------------------------------------
# Command prompt
# ----------------------------------------------------------------------------

RED="\[\e[0;31m\]"
GRE="\[\e[0;32m\]"
YEL="\[\e[0;33m\]"
BLU="\[\e[0;34m\]"
MAG="\[\e[0;35m\]"
CYN="\[\e[0;36m\]"
GRA="\[\e[0;37m\]"

# https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

parse_virtual_env() {
    echo $VIRTUAL_ENV | sed -e "s/.*virtualenvs\///" -e "s/-.*//"
}

__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1="\n${GRE}[\w] ${YEL}\$(parse_git_branch) ${RED}\$(echo $EXIT)"

    if [ $EXIT != 0 ]; then
        PS1+="   <<<<-<<<--------------\n"
    else
        PS1+="\n"
    fi

    PS1+="${MAG}(\$(parse_virtual_env)) ${BLU}\u${GRA} \\$ "
}

__prompt_command_empty() {
  local PASS="0"
}

# PS1="\n${GRE}[ \w ]${YEL}\$(parse_git_branch)\n${BLU}\u${GRA} \\$ "
PROMPT_COMMAND=__prompt_command

# ----------------------------------------------------------------------------
# lol
# ----------------------------------------------------------------------------
alias please="sudo"

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
        local destination=${bookmark_line/$bookmark_name \~//home/zachtaira}
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

# Open folder at Bookmark
whizo () {
    local bookmark_name="$1"
    if [ "$bookmark_name" == "help" ]; then
        zmansynopsis whiz
    elif [ -n "$bookmark_name" ]; then
        local bookmark_line=$(grep "$bookmark_name " ~/.NERDTreeBookmarks)
        local destination=${bookmark_line/$bookmark_name \~//home/zachtaira}
        local final_destination=${destination/$bookmark_name /}
        echo "Whizzing to $final_destination"
        open $final_destination
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
    local man_file="/home/zachtaira/zman.md"
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
    local man_file="/home/zachtaira/zman.md"
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
# Vim function - conveniently open a bunch of stuff in vim
# ============================================================================
vo() {
    if [ -z "$2" ]; then
        grep -ril "$1" . | grep -v "^\./\." | grep -v ".*__pycache__.*"
        vi $(grep -ril "$1" . | grep -v "^\./\." | grep -v ".*__pycache__.*")
    else
        grep -ril "$1" "$2" | grep -v "^\./\." | grep -v ".*__pycache__.*"
        vi $(grep -ril "$1" "$2" | grep -v "^\./\." | grep -v ".*__pycache__.*")
    fi
}
