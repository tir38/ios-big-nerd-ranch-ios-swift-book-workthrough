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

// 
println("\n\n")
func canHasTwoDefaults(#arg1: String,
    omitableArg1: String = "lol",
    omitableArg2: String = "narf") {
        println(arg1 + omitableArg1 + omitableArg2)
}


canHasTwoDefaults(arg1: alpha, omitableArg1: beta, omitableArg2: gamma)
canHasTwoDefaults(arg1: alpha)

