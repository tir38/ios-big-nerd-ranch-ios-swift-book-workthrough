import UIKit

class ItemsViewController: UITableViewController {

    private let itemStore: ItemStore
    private let imageStore: ImageStore
    
    @IBOutlet
    private var headerView: UIView!
    
    init(itemStore: ItemStore, imageStore: ImageStore) {
        self.itemStore = itemStore
        self.imageStore = imageStore
        
        super.init(nibName: nil, bundle: nil)
        
        // set nav bar
        navigationItem.title = "Homepwner"
        let addItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewItem:")
        navigationItem.rightBarButtonItem = addItem
        navigationItem.leftBarButtonItem = editButtonItem()
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
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
            imageStore.deleteImageForKey(item.itemKey)
            
            // update data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // get item from store to hand off
        let item = itemStore.items[indexPath.row]
        
        let detailViewController = DetailViewController(item: item, itemStore: itemStore, imageStore: imageStore)
        
        // push detailviewcontroller on stack
        showViewController(detailViewController, sender: self)
    }

}
