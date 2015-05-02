//: Playground - noun: a place where people can play

import Cocoa

println("The maximum Int value is \(Int.max)")
println("The minimum Int value is \(Int.min)")

println("The maximum value for a 32-bit integer is \(Int32.max)")
println("The minimum value for a 32-bit integer is \(Int32.min)")

println("The maximum UInt value is \(UInt.max)")
println("The minium UInt value is \(UInt.min)")

let numberOfPages: Int = 10 // declare explicit type
let numberOfChapters = 3 // implicit type declaration

let numberOfPeople: UInt = 40
let volumeAdjustment: Int32 = -1000

println(10 + 20)
println(30 - 5)
println(5*6)
println(10/4) // returns quotent and drops remainder

println(10 + (2*5))
println((30 - 5) - 5)

println(11 % 3)
println(-11 % 3)

var x = 10
x++
println(x)
x--
println(x)

x += 10
println(x)

let y: Int8 = 120
let z = y &+ 10
println(z)

let a: Int16 = 200
let b: Int8 = 50
//let c: a + Int16(b)
//println(c)


let d1 = 1.1 // implicitly a Double
let d2: Double = 1.1
let f1: Float = 100.3

println(10.0 + 11.4)
println(11.0 / 3.0)
