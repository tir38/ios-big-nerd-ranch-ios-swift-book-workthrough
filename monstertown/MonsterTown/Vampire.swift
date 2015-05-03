import Foundation

class Vampire: Monster {
    
    var peopleTurnedIntoVampires: [Vampire] = []; // people turned into vampires by this vampire
    
    override func terrorizeTown() {
        var currentPopulation = town?.population ?? 0
        if currentPopulation > 0 {
            town?.changePopulation(-1)
            peopleTurnedIntoVampires.append(Vampire())
        } else {
            town = nil // leave town
        }
        super.terrorizeTown()
    }
}