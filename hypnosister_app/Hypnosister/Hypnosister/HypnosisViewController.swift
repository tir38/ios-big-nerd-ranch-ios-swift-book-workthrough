import UIKit

class HypnosisViewController: UIViewController {

    weak private var textLabel: UILabel!
    
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
        
        // setup the label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.center = view.center
        label.font = UIFont.systemFontOfSize(24)
        label.textAlignment = .Center
        label.text = "Bill\nFreakout"
        label.numberOfLines = 2
        view.addSubview(label)
        textLabel = label
    }
    
    override func viewDidLoad() {
        println("hypnosis view loaded")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textLabel.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
            
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: .Autoreverse | .Repeat,
            animations: {
                self.textLabel.alpha = 1.0
            },
            completion: nil)
    }
}
