import Foundation


struct Mayor {
    
    func notifiyOfPopulationChange(populationChange : Int ) {
        if populationChange < 0 {
            println("I'm deeply saddened to hear about this latest tragedy of \(-1 * populationChange) deaths at the hands of the monsters. I promise that my office is looking into the nature of this rash of violence.")
        }
    }
}