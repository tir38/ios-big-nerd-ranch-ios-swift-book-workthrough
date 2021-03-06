import UIKit

class DetailViewController: UIViewController,
                                UINavigationControllerDelegate,
                                UIImagePickerControllerDelegate,
                                UITextFieldDelegate {
    
    // MARK: outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueInDollarsField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // MARK: properties
    private let itemStore: ItemStore
    private var item: Item
    private let imageStore: ImageStore
    
    // MARK: initializers
    init(item: Item, itemStore: ItemStore, imageStore: ImageStore) {
        self.item = item
        self.itemStore = itemStore
        self.imageStore = imageStore
        
        super.init(nibName: "DetailViewController", bundle: nil)
        
        navigationItem.title = item.name
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("use init(itemStore:) instead")
    }
    
    // MARK: view lifecycle
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
        
        let image = imageStore.imageForKey(item.itemKey)
        imageView.image = image
    }
    
    override func viewWillDisappear(animated: Bool) {
        view.endEditing(true)
        
        // save to store
        item.name = nameField.text
        item.valueInDollars = valueInDollarsField.text.toInt() ?? 0
        item.serialNumber = serialNumberField.text
        itemStore.updateItem(item)
    }
    
    // MARK: actions
    @IBAction func takePicture(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
         // check if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil) // we use "present" instead of "show" for modal view controllers
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // MARK: private
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        // get image from dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // set on image view
        imageView.image = image
        
        // save to dictionary
        imageStore.setImage(image, forKey: item.itemKey)
        
        // we have to manually disimss modal view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
}


