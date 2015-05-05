import UIKit

class ReminderViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        tabBarItem.title = "Remind"
        tabBarItem.image = UIImage(named: "Time.png")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(nibName: "ReminderViewController", bundle: nil)
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addReminder(sender: AnyObject) {
        let date = datePicker.date
        
        let note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = date
        UIApplication.sharedApplication().scheduleLocalNotification(note)
    }
    
    override func viewDidLoad() {
        println("reminder view loaded")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.minimumDate = NSDate(timeIntervalSinceNow: 60)
    }
}
