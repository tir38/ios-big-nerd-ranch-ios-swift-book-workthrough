
import UIKit

class ItemStore: NSObject {
 
    var items: [Item] = []
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        items.append(newItem)
        return newItem
    }
}
