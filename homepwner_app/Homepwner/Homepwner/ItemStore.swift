
import Foundation


class ItemStore: NSObject {
 
    private static let ItemArchiveKey = "items.archive"
    
    // MARK: public properties
    var items: [Item] = []

    // MARK: private properties
    private let itemArchiveUrl: NSURL = {return UrlHelper.urlForKey(ItemStore.ItemArchiveKey)}()
    
    // MARK: init methods
    
    override init() {
        super.init()

        // repopulate from archive
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveUrl.path!) as? [Item] {
            items += archivedItems
        }
    }
    
    // MARK: public methods
    
    func createItem() -> Item {
        let newItem = Item(random: false)
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
    
    func updateItem(item: Item) {
        // find this item in array
        if let index = find(items, item) {
            items[index] = item
        } else {
            println("Failed to add item to store: \(item.name)")
        }
    }
    
    func saveChanges() -> Bool {
        println("saving items to: \(itemArchiveUrl.path)")
        return NSKeyedArchiver.archiveRootObject(items, toFile: itemArchiveUrl.path!)
    }
    
    // MARK: private methods
    
    private func isWithinBounds(index: Int) -> Bool {
        return index >= 0 && index < items.count
    }
}
