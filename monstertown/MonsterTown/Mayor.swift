import Foundation


struct Mayor {
 
    private var anxietyLevel:Int = 0
    
    mutating func notifiyOfPopulationChange(populationChange : Int ) {
        if populationChange < 0 {
            
            anxietyLevel++
            
            println("I'm deeply saddened to hear about this latest tragedy of \(-1 * populationChange) deaths at the hands of the monsters. I promise that my office is looking into the nature of this rash of violence.")
        }
    }
}