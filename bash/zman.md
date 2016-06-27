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

### todochange
NAME
    todochange -- change a row in the task database

SYNOPSIS
    todochange task_id column_name column_value

DESCRIPTION
    Todochange will set column_name to column_value in the row task_id. For
    example, calling:
        todochange 3 end 1995-12-3

    will set task 3's "end" column to equal 1995-12-3. 
endtodochange

### todocomplete
NAME
    todocomplete -- completes a task with the current or a provided date

SYNOPSIS
    todocomplete task_id [end_date]

DESCRIPTION
    If an end_date is not provided, this function will complete the task_id
    with the current date. If an end date is provided, this function 
    will complete task_id with the provided end date. 

endtodocomplete
endmodule

## zman (module)
### zman
NAME
    zman -- search the documentation for a zach-related function

SYNOPSIS
    zman func_to_search

DESCRIPTION
    Calling zman will print out a description of the function operand you give
    it. These function descriptions are stored in the zman.md file, and are
    formatted as follows:

    ## module_name (module)
    ### module_function
    NAME
        module_function - description of module_function

    SYNOPSIS
        module_function required_argument [optional_argument]

    DESCRIPTION
        Description of module_function in more depth. 

    endmodule_function
    endmodule

endzman

### zmansynopsis
NAME
    zmansynopsis -- get the synopsis of a zach-related function

SYNOPSIS
    zmansynopsis func_to_search

DESCRIPTION
    Calling zmansynopsis will print out the synopsis of the function operand
    you give it. For example, calling:
        zmansynopsis zmansynopsis

    would print the synopsis for this function, which is:
    SYNOPSIS
        zmansynopsis func_to_search

endzmansynopsis
endmodule
