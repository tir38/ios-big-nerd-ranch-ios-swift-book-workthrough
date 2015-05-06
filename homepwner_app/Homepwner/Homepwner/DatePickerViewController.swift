
import UIKit

class DatePickerViewController: UIViewController {

    private var item: Item
    private var itemStore: ItemStore
    
    @IBOutlet weak var itemDatePicker: UIDatePicker!
    
    init(item: Item, itemStore: ItemStore) {
        self.item = item
        self.itemStore = itemStore
        
        super.init(nibName: "DatePickerViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        // get date from item and set datepicker
        let date = item.dateCreated
        itemDatePicker.setDate(date, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        // save new date on item
        item.dateCreated = itemDatePicker.date
        itemStore.updateItem(item)
    }
}
