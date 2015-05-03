import Cocoa


// I can use optional binding to create a temp constant
var errorCodeString: String?
errorCodeString = "404"
if let theError = errorCodeString  {
    println(theError)
}


// I can use optional binding to create a temp variable too
var myString: String?
myString = "jason"

if let var unWrapped = myString {
    println(unWrapped)
}


// DANGER! implicitly unwrapped optional
var danger: String!
danger = "404"
println(danger)


// optional chainging
var errorCodeInt: Int? = errorCodeString?.toInt()?.advancedBy(1) // unwrap two things

if let errInt = errorCodeInt {
    print("The integer error code is \(errInt)")
} else {
    println("errorCodeString was either nil or could not be converted to int")
}


// nil coalescing
errorCodeString = "404a"
let actualErrorCode = errorCodeString?.toInt() ?? 500
println("actual error code: \(actualErrorCode)")


// challenge
var fuse:Int? = nil // create optional that is nil
let gunpowder = fuse! // light the fuse
println(gunpowder) // fatal error: unexpectedly found nil while unwrapping an Optional value
