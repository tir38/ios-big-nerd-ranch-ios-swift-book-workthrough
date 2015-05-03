
import Foundation

class Monster {
    var town: Town?
    var name = "Monster"
    
    func terrorizeTown() {
        if let town = town {
            println("\(name) is terrorizing its town")
        } else {
            println("\(name) is still roving between towns.")
        }
    }
}