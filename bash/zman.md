Zach's Man Pages
================

## whiz (module)
### whiz
NAME
    whiz -- display and/or navigate to bookmarks set in a text file

SYNOPSIS
    whiz [bookmark_name]

DESCRIPTION
    Search the bookmark file for a given bookmark name and navigate to the
    directory file associated with that bookmark. 

    If no bookmark name is given, display the list of bookmarks. The bookmarks
    will be displayed as follows:

    Here are the bookmarks you can currently whiz to:
    [name]..............[directory]
    [name]..............[directory]

endwhiz

### whizadd
NAME
    whizadd -- add the current directory to the whiz bookmarks file

SYNOPSIS
    whizadd bookmark_name

DESCRIPTION
    Upon passing in a bookmark name, this function will create the bookmark
    bookmark_name that is associated with the current directory. This bookmark
    will be stored in the whiz bookmarks file, and will be stored in the
    following format:

    [bookmark_name] [directory]

endwhizadd
endmodule

## frag (module)
### frag
NAME
    frag -- spin out certain sections of a text file into a second file

SYNOPSIS
    frag file_name [single_line] [multiline_start..multiline_end] [...]

DESCRIPTION
    If no operands besides the file name is provided, frag will simply
    output the text of the file with line numbers.
    
    If line numbers in addition to the file name are provided, frag will
    take those lines and put them in a file called frag.txt. The order of the
    lines will be maintained. 
    
    For example, calling:
        frag example.txt 1 3..5 2 5..7

    will create a file with the following line order:
    1
    3
    4
    5
    2
    5
    6
    7

endfrag
endmodule

## todo (module)
### todo
NAME
    todo -- display the list of tasks stored in the database

SYNOPSIS
    todo [all] [done] [help]

DESCRIPTION
    Calling todo with no operands will display all the tasks in the database
    where end=''. In other words, it will display all the unfinished tasks.
    You can modify the output of todo with the following options:

    all     Display all the tasks in the database

    done    Display all the completed tasks in the database

    help    Display a list of functions in the todo module along with their
            respective uses

endtodo
endmodule
