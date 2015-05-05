
import UIKit

class ItemStore: NSObject {
 
    var items: [Item] = []
    
    private static let expensiveThreshold = 50 // all items greater in value than this are "expensive"
    
    var numberExpensiveItems: Int {
        var count: Int = 0
        for item: Item in items {
            if item.valueInDollars > ItemStore.expensiveThreshold {
                count++
            }
        }
        return count
    }
    
    var numberInexpensiveItems: Int {
        return items.count - numberExpensiveItems
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        items.append(newItem)
        return newItem
    }
    
    // return's the i'th expensive item
    func getExpensiveItem(i: Int) -> Item? {
        // scan list for the i'th expensive item
        var tempIndex: Int = 0
        for item: Item in items {
            if item.valueInDollars > ItemStore.expensiveThreshold {
                if tempIndex == i {
                    return item
                }
                tempIndex++
            }
        }
        return nil
    }

    // returns the i'th inexpensive item
    func getInexpensiveItem(i: Int) -> Item? {
        // scan list for the i'th expensive item
        var tempIndex: Int = 0
        for item: Item in items {
            if item.valueInDollars <= ItemStore.expensiveThreshold {
                if tempIndex == i {
                    return item
                }
                tempIndex++
            }
        }
        return nil
    }
}
