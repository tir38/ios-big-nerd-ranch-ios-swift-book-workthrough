
import Foundation

struct Town {
    var population = 1
    var numberOfStoplights = 4
    
    func printDescription() {
        println("Town has \(population) citizens and \(numberOfStoplights) stop lights.")
    }
    
    mutating func changePopulation(amount: Int) {
        population += amount
    }
    
}