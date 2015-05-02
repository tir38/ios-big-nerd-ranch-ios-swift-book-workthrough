//: Playground - noun: a place where people can play

import Cocoa

var int: Int = 0
for i in 1...5 { // i is of implied type Int
    ++int
    println(int)
    println("i = \(i)") // cool! i is automatically incremented
}

for var i = 1; i < 5; i++ {
    println("i = \(i)")
}

var j = 1
while j < 6 {
    println("j = \(j)")
    j++
}

var k = 1
do {
    println("go do this")
    k++
} while k < 3
println("king of the castle")

var shields = 5
var blasterIsOverheating = false
var blasterFireCount = 0
var spaceDemonsDestroyed = 0
while shields > 0 {
    
    
    if (spaceDemonsDestroyed == 50) {
        println("You win! Space assholes destroyed.")
        break;
    }
    
    if blasterIsOverheating {
        println("Blasters are overheating! Cooldown initiated.")
        sleep(2)
        println("Blasters ready to fire.")
        sleep(1)
        blasterIsOverheating = false
        blasterFireCount = 0
        continue
    }
    
    if (blasterFireCount > 10) {
        blasterIsOverheating = true
        continue
    }
    
    println("Fire blasters!")
    
    ++blasterFireCount
    ++spaceDemonsDestroyed
}

// challenge
for i in 0...4 {
    for var j = 0; j<100; j++ {
        var pair = (i,j)
        println("pair = (\(pair.0), \(pair.1))")
    }
}
