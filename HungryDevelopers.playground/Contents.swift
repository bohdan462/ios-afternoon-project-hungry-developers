import Foundation

struct JSON { }
// Declaration of a function that receives another function
// input: single function that receives a boolean and returns nothing
// output: void
func goToNetwork(_ parsingFunction: (Data) -> JSON) {
    let dataFromNetwork = Data()
    parsingFunction(dataFromNetwork) // equivalent of print("Returned from network")
}
// -----
// Executing of the function `goToNetwork`
// using an anonymous function (closure)
goToNetwork { result in
    print("Closure: Returned from network")
    return JSON()
} // anonymous, it has no name, it is a closure
// -----
// Executing of the function `goToNetwork`
// using an existing function
func printReturnFromNetwork(_ result: Data) -> JSON {
    print("Func: Returned from network")
    return JSON()
}
goToNetwork(printReturnFromNetwork(_:)) // passing a named function
// -----
// Executing of the function `goToNetwork`
// using a closure and a label
let labeledClosure: (Data) -> JSON = { dataInput in
    // Closure with a label
    print("Label Closure: Returned from network")
    return JSON()
}
goToNetwork(labeledClosure)
