//: Playground - noun: a place where people can play

import Cocoa

let playground = "Hello, playground"
var mutablePlayground = "Hello, mutable playground"

mutablePlayground += "!"

for c: Character in mutablePlayground {
    println("\(c)")
}

let oneCoolDude = "\u{1F60E}"
let aAcute = "\u{0061}\u{0301}"

for scalar in playground.unicodeScalars {
    println("\(scalar.value)")
}

let aAcutePrecomposed = "\u{00E1}"

let b = (aAcute == aAcutePrecomposed)

// same count
count(aAcute)
count(aAcutePrecomposed)

// manually advance through chars in a string
let fromStart = playground.startIndex
let toPostion = 4
let end = advance(fromStart, toPostion)
let fifthChar = playground[end]

// get range of chars
let range = fromStart...end
let firstFiveChars = playground[range]

// bronze challenge
var startsWithHello = playground.hasPrefix("Hello")

// silver challenge
let helloAsUnicode = "\u{0048}" // H
    + "\u{0065}" // e
    + "\u{006C}" // l
    + "\u{006C}" // l
    + "\u{006F}" // o

startsWithHello = playground.hasPrefix(helloAsUnicode)
