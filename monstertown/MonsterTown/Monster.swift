
import Foundation

class Monster {

    class var spookyNoises:String {
        return "Booo......!"
    }
    
    var town: Town?
    var name = "Monster"
    
    var victimPool : Int {
        get {
            return  town?.population ?? 0
        }
        set (newVictimPool) {
            town?.population = newVictimPool
        }
    }
    
    func terrorizeTown() {
        if let town = town {
            println("\(name) is terrorizing its town")
        } else {
            println("\(name) is still roving between towns.")
        }
    }
    

    
}