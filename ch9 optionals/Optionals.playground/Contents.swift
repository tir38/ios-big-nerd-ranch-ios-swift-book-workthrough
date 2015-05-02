//: Playground - noun: a place where people can play

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

if var unWrapped = myString {
    println(unWrapped)
}

// DANGER! implicitly unwrapped optional
var danger: String!
danger = "404"
println(danger)

// optional chainging
var errorCodeInt: Int?
errorCodeInt = errorCodeString?.toInt()


