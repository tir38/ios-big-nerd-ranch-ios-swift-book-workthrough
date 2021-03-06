

var myTown = Town()
myTown.printDescription()
myTown.changePopulation(15)

// play with town size
var ts = myTown.townSize
println(ts.rawValue)

myTown.changePopulation(50)
myTown.printDescription()
ts = myTown.townSize
println(ts.rawValue)

// create generic monster
let genericMonster = Monster()
genericMonster.terrorizeTown()
genericMonster.town = myTown
genericMonster.terrorizeTown()

// create zombie
let fredTheZombie = Zombie()
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()
fredTheZombie.changeName("Fred", walksWithLimp: true)
fredTheZombie.terrorizeTown()
println(Zombie.spookyNoises)
fredTheZombie.isFallingApart

// terrorize until it can't terrorize any more
fredTheZombie.terrorizeTown()
fredTheZombie.terrorizeTown()
fredTheZombie.terrorizeTown()
fredTheZombie.terrorizeTown()
fredTheZombie.terrorizeTown()
fredTheZombie.terrorizeTown()
fredTheZombie.terrorizeTown()
fredTheZombie.terrorizeTown()

let zombie1 = Zombie()
zombie1.walksWithLimp = false
let zombie2 = zombie1
zombie2.walksWithLimp = true
println("Zombie 1 walks with a limp? \(zombie1.walksWithLimp)")
println("Zombie 2 walks with a limp? \(zombie2.walksWithLimp)")


// create vampire
let bobTheVampire = Vampire()
bobTheVampire.name = "Bob"
myTown.changePopulation(-50)
bobTheVampire.town = myTown

// terrorize until everyone is a vampire
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()
bobTheVampire.terrorizeTown()