import std/strutils

type
    Task = object
        name: string
        description: string

proc print_tasks(t : var seq[Task]) : void =
    echo "here are your tasks:"
    for task in t:
        echo task.name & " | " & task.description
    discard

proc enter_tasks(): seq[Task] =
    echo "enter # of tasks"
    var n = readLine(stdin).parseInt()
    var tasks : seq[Task] = @[]
    var i = 0
    while i < n:
        echo "enter your task (name, description)"
        let task_data = readLine(stdin)
        let  split  = task_data.split(',')
        let (name, desc) = (split[0], split[1])
        let t = Task(name: name, description:desc)
        tasks.add(t)
        i = i + 1
    tasks



when isMainModule:
    #[ let t1 = Task(name:"test1", description:"test")
    tasks.add(t1) ]#
    var ts = enter_tasks()
    print_tasks(ts)