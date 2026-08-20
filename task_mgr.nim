import std/strutils
import std/terminal

type
    Task = object
        name: string
        description: string
    InputTaskError = object of ValueError

proc print_tasks(t : var seq[Task]) : void =
    stdout.styledWriteLine({styleBlink}, "here are your tasks")
    for task in t:
        echo task.name & " | " & task.description
    discard

proc enter_tasks(): seq[Task] =
    stdout.styledWriteLine({styleUnderscore},"enter # of tasks")
    var n = readLine(stdin).parseInt()
    var tasks : seq[Task] = @[]
    var i = 0
    while i < n:
        stdout.styledWriteLine({styleBlink}, "enter your task (name, description)")
        let task_data = readLine(stdin)
        let  split  = task_data.split(',')
        if len(split) < 2:
            raise newException(InputTaskError,getCurrentExceptionMsg())
        let (name, desc) = (split[0], split[1])
        let t = Task(name: name, description:desc)
        tasks.add(t)
        i = i + 1
    tasks



when isMainModule:
    setBackgroundColor(bgRed,true)
    var ts = enter_tasks()
    print_tasks(ts)