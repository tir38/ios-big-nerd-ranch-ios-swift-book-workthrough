import UIKit

class ItemsViewController: UITableViewController {

    private let itemStore: ItemStore
    
    @IBOutlet
    private var headerView: UIView!
    
    init(itemStore: ItemStore) {
        self.itemStore = itemStore    
        super.init(nibName: nil, bundle: nil)
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 44
        
        // setup tableview's nib
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: ItemCell.ViewIdentifier)
        
        // setup header view
        NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)
        tableView.tableHeaderView = headerView
    }
    
    @IBAction
    func addNewItem(sender: AnyObject) {
        // add new item to item store. first!
        let newItem = itemStore.createItem()
        
        // figure out where that item is in the array
        if let index = find(itemStore.items, newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // insert new row at index path
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        }
    }
    
    @IBAction
    func toggleEditMode(sender: AnyObject) {
        setEditing(!editing, animated: true)
        let title: String = editing ? "Done": "Edit"
        sender.setTitle(title, forState: .Normal)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCell.ViewIdentifier, forIndexPath: indexPath) as! ItemCell
        
        let item = itemStore.items[indexPath.row]
        cell.nameLabel.text = item.name
        cell.valueLabel.text = "$ \(item.valueInDollars)"
        cell.serialNumberLabel.text = item.serialNumber
        return cell
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        itemStore.moveItem(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // if table view is asking to commit a delete command
        if editingStyle == .Delete {
            // update store
            let item = itemStore.items[indexPath.row]
            itemStore.removeItem(item)
            
            // update data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "Remove"
    }
}