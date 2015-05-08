
import UIKit

class PhotosViewController: UIViewController {

    var store: PhotoStore!
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: view lifecycle methods
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        store.fetchRecentPhotos()
    }
    
}
