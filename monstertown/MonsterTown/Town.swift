
import Foundation

struct Town {
    
    static let region = "South"
    
    var population: Int = 1 {
        didSet(oldPopulation) {
            println("The population has changed from \(oldPopulation) to \(population)")
        }
    }
    
    var numberOfStoplights = 4
    var townSize: Size {
        get {
            precondition(self.population >= 0, "Town cannot have negative population.")
            
            switch  self.population {
                case 0...10:
                    return Size.Small
                case 11...50:
                    return Size.Medium
                default:
                    return Size.Large
            }
        }
    }
    
    func printDescription() {
        println("Town has \(population) citizens and \(numberOfStoplights) stop lights.")
    }
    
    mutating func changePopulation(amount: Int) {
        population += amount
    }
    
    enum Size: String {
        case Small = "Small"
        case Medium = "Medium"
        case Large = "Large"
    }
}