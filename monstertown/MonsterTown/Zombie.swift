
import Foundation

class Zombie: Monster {
    var walksWithLimp = true
    
    override func terrorizeTown() {
        super.terrorizeTown()
        
        var curPop = town?.population ?? 0
        
        if (curPop <= 0) {
            return
        }
        
        if curPop  > 10 {
            town?.changePopulation(-10)
        } else {
            town?.changePopulation(-1 * curPop)
            town = nil // leave town
            println("\(name) is leaving town")
        }
    }
    
    func changeName(name: String, walksWithLimp:Bool) {
            self.name = name
            self.walksWithLimp = walksWithLimp
    }
}

