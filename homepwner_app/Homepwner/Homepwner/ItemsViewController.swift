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
    
    // return number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.items.count + 1
    }
    
    // retun cell view for specific row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCell.ViewIdentifier, forIndexPath: indexPath) as! ItemCell
        
        // if last row
        if indexPath.row == itemStore.items.count {
            cell.nameLabel.text = "No more items!"
            cell.serialNumberLabel.text = ""
            cell.valueLabel.text = ""
        } else {
            let item = itemStore.items[indexPath.row]
            cell.nameLabel.text = item.name
            cell.valueLabel.text = "$ \(item.valueInDollars)"
            cell.serialNumberLabel.text = item.serialNumber
        }
        
        return cell
    }
    
    // after user drags item in editing, do any datastore update
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        // don't allow moving anything *to* the last row
        if destinationIndexPath.row == itemStore.items.count {
            return
        }
        
        itemStore.moveItem(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    // handle item deletion
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // don't allow removing of the last (footer item)
        if indexPath.row == itemStore.items.count {
            return
        }
        
        // if table view is asking to commit a delete command
        if editingStyle == .Delete {
            // update store
            let item = itemStore.items[indexPath.row]
            itemStore.removeItem(item)
            
            // update data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // set text for delete confirmation button
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "Remove"
    }
    
    // set which rows can be edited
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // allow editing for all rows except last
        return indexPath.row != itemStore.items.count
    }

    // when user tries to move item, return where *you* want to put that item
    // i.e. you can override user's wishes on where to move an item
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {

        // if trying to item move to the end, then return source (i.e. don't let user move item to the end)
        // otherwise let user move to proposed index path
        if proposedDestinationIndexPath.row != itemStore.items.count {
            return proposedDestinationIndexPath
        } else {
            return sourceIndexPath
        }
    }
}