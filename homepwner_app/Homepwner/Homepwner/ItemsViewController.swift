import UIKit

class ItemsViewController: UITableViewController {

    private let itemStore: ItemStore
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore    
        super.init(nibName: nil, bundle: nil)
        
        for _ in 0...20 {
            self.itemStore.createItem()
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        // register nib
        tableView.registerNib(nib, forCellReuseIdentifier: ItemCell.ViewIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case 0:
                return itemStore.numberExpensiveItems
                
            case 1:
                return itemStore.numberInexpensiveItems

            case 2:
                return 1 // one final footer section
            
            default:
                fatalError("you don't have a section numbered \(section)")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section != 2 {
            return CGFloat(60)
        }
        return CGFloat(44)

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCell.ViewIdentifier, forIndexPath: indexPath) as! ItemCell
        
        let section = indexPath.section
        let row = indexPath.row
        
        var item: Item?
        
        switch section {
            case 0:
                item = itemStore.getExpensiveItem(row)
                setupCellForItem(item, cell: cell)

            case 1:
                item = itemStore.getInexpensiveItem(row)
                setupCellForItem(item, cell: cell)
            
            case 2:
                cell.nameLabel.text = "No more items"
                cell.valueLabel.text = ""
                cell.serialNumberLabel.text = ""
            
            default:
                fatalError("you don't have a section numbered \(section)")
        }
        
        return cell
    }
    
    private func setupCellForItem(item: Item?, cell: ItemCell) {
        
        if let item = item {
            cell.nameLabel.text = item.name
            cell.valueLabel.text = "\(item.valueInDollars)"
            cell.serialNumberLabel.text = item.serialNumber
        }
    }
}
