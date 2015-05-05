import UIKit

class HypnosisViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        tabBarItem.title = "Hypno-Bill"
        tabBarItem.image = UIImage(named: "Hypno.png")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init()  {
        self.init(nibName: "HypnosisViewController", bundle: nil)
    }
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let backgroundView = HypnonsisView(frame: frame)
        
        // set the background as *the (one and only)* view for this controller
        view = backgroundView
    }
    
    override func viewDidLoad() {
        println("hypnosis view loaded")
    }
}
