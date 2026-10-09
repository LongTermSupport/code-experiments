[<EntryPoint>]
let main _ =
    let greet = fun name -> printfn "Hello, %s" name
    greet "world"
    0
