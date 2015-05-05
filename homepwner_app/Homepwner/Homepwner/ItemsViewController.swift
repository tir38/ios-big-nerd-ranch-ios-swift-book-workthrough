import UIKit

class ItemsViewController: UITableViewController {

    private let itemStore: ItemStore
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore    
        super.init(nibName: nil, bundle: nil)
        
        for _ in 0...4 {
            self.itemStore.createItem()
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 44
        
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        // register nib
        tableView.registerNib(nib, forCellReuseIdentifier: ItemCell.ViewIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCell.ViewIdentifier, forIndexPath: indexPath) as! ItemCell
        
        let item = itemStore.items[indexPath.row]
        cell.nameLabel.text = item.name
        cell.valueLabel.text = "\(item.valueInDollars)"
        cell.serialNumberLabel.text = item.serialNumber
        
        
        return cell
    }
}
