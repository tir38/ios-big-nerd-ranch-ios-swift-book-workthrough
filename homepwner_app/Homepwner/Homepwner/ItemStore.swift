
import UIKit

class ItemStore: NSObject {
 
    var items: [Item] = []
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        items.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = find(items, item) {
            items.removeAtIndex(index)
        }
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        // check index bounds
        if (!isWithinBounds(fromIndex) || !isWithinBounds(toIndex)) {
            fatalError("Index out of bounds.")
        }
        
        // remove and insert
        items.insert(items.removeAtIndex(fromIndex), atIndex: toIndex)
    }
    
    private func isWithinBounds(index: Int) -> Bool {
        return index >= 0 && index < items.count
    }
}
