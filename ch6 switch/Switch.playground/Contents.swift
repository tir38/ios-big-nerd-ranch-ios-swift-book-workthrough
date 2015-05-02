//: Playground - noun: a place where people can play

import Cocoa

var statusCode: Int = 420
var errorString: String = "The request failed with the error: "

switch statusCode {
case 100, 101:
    errorString += " Informational, \(statusCode)"
case 204:
    errorString += " Successful but no content, 204."
case 300...307:
    errorString += " Redirectional, \(statusCode)"
case 400...417:
    errorString += " Client error, \(statusCode)"
case 500...505:
    errorString += " Server error, \(statusCode)"
    
case let unknownCode where (unknownCode >= 200 && unknownCode < 300)
    || unknownCode > 505:
    errorString = "\(unknownCode) is not a known code."
    
default:
    errorString = "Unexpected error occured."
}


let error = (code: statusCode, error: errorString)
error.code
error.error


switch error {    case (400...505, _):        println("PANIC!")    default:        println("Not worth panicking.")}