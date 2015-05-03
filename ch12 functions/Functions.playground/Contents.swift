//: Playground - noun: a place where people can play

import Cocoa

// single parameter function
func printPersonalGreeting(name: String) {
    println("Hello \(name), welcome to the party.")
}

printPersonalGreeting("Jason")

// external argument labels
func divisionDescription(#numerator: Double,
    #denominator: Double) {
        
    println("\(numerator) divided by \(denominator) equals \(numerator/denominator)")
}

divisionDescription(numerator: 10, denominator: 2)


// variadic input
func printPersonalGreeting(#names: String...) {
    for name in names {
        println("Hello \(name), welcome to the party.")
    }
}

printPersonalGreeting(names: "Alice", "Bob", "Carl")


// default parameter values
func divisionDescriptionSentence(#numerator: Double,
    #denominator: Double,
    punctuation: String = ".") 	{ // by providing default value for punctuation, our external name for this param is automatically "punctuation"; we don't have to prefix with # like other parameters

        println("\(numerator) divided by \(denominator) equals \(numerator/denominator)\(punctuation)")
}

divisionDescriptionSentence(numerator: 9, denominator: 3)
divisionDescriptionSentence(numerator: 12, denominator: 3, punctuation: "!")

// skipping default values
println("\n")
func canHasTwoDefaults
    (arg1: String, // i can have args with no public-facing     
    omitableArg1: String = "default1", // all my args with default values MUST have public-facing name
    omitableArg2: String = "default2") {

        println(arg1 + " " + omitableArg1 + " " + omitableArg2)
}

canHasTwoDefaults("alpha", omitableArg1: "beta", omitableArg2: "gamma")
canHasTwoDefaults("alpha", omitableArg2: "epsilon")// so i can "skip" an omittable item


// inout paramters
println("\n")
var error = "The request failed: "
func appendError(#errorCode: Int, inout #errorString:String) {
    if errorCode == 400 {
        errorString += "Bad request!"
    }
}
println(error)

appendError(errorCode: 400, errorString: &error)
println(error)


// return values
println("\n")
func divisionDescriptionString(#numerator: Double, #denominator: Double) -> String {
    return "\(numerator) divided by \(denominator) equals \(numerator/denominator)"
}

var output = divisionDescriptionString(numerator: 15, denominator: 3)
println(output)



// silver challenge
println("\n")
func beanSifter(list: [String]) -> (beans:[String], others:[String]) {
    var beans = [String]()
    var others = [String]()
    
    for value:String in list {
        if value.hasSuffix("beans") {
            beans.append(value)
        } else {
            others.append(value)
        }
    }
    return (beans, others)
}

var myList = ["pinto beans", "ramen", "milk", "butter", "kidney beans"]
var sortedLists = beanSifter(myList)
println("beans: \(sortedLists.beans)")
println("other things: \(sortedLists.others)")


