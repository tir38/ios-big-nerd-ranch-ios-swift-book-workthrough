import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueInDollarsField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let itemStore: ItemStore
    private var item: Item
    
    init(item: Item, itemStore: ItemStore) {
        self.item = item
        self.itemStore = itemStore
        
        super.init(nibName: "DetailViewController", bundle: nil)
        
        navigationItem.title = item.name
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("use init(itemStore:) instead")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // repopulate fields
        nameField.text = item.name
        valueInDollarsField.text = "\(item.valueInDollars)"
        if let sn = item.serialNumber {
            serialNumberField.text = sn
        }
        
        let date = item.dateCreated
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle // Bruce Lee
        dateLabel.text = dateFormatter.stringFromDate(date)
    }
    
    override func viewWillDisappear(animated: Bool) {
        view.endEditing(true)
        
        // save to store
        item.name = nameField.text
        item.valueInDollars = valueInDollarsField.text.toInt() ?? 0
        item.serialNumber = serialNumberField.text
        itemStore.updateItem(item)
    }
}
