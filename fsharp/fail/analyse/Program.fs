module hello

type point = { X: int }

let Greet_Name = "world"

[<EntryPoint>]
let main _ =
    printfn "Hello, %s" Greet_Name
    0
