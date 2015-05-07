
import Foundation
import UIKit

class ImageStore: NSObject {
    
    private var imageDictionary = [String:UIImage]()

    // MARK: init methods
    override init() {
        super.init()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "clearCache:",
            name: UIApplicationDidReceiveMemoryWarningNotification,
            object: nil)
    }
    
    // MARK: public methods
    
    func setImage(image: UIImage, forKey key: String) {
        imageDictionary.updateValue(image, forKey: key)
        
        // write to disk
        let imageURL = imageURLForKey(key)
        let data = UIImageJPEGRepresentation(image, 0.5)
        data.writeToURL(imageURL, atomically: true)
    }
    
    func imageForKey(key: String) -> UIImage? {
        
        if let existingImage = imageDictionary[key] {
            return existingImage
        } else {
            let imageURL = imageURLForKey(key)
            
            if let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) {
                // update dictionary and return
                imageDictionary[key] = imageFromDisk
                return imageFromDisk
            } else {
                return nil
            }
        }
    }
    
    func deleteImageForKey(key: String) {
        imageDictionary.removeValueForKey(key)
        
        // remove from disk
        let imageURL = imageURLForKey(key)
        NSFileManager.defaultManager().removeItemAtURL(imageURL, error: nil)
    }
    
    func imageURLForKey(key: String) -> NSURL {
        return UrlHelper.urlForKey(key)
    }
    
    private func clearCache(note: NSNotification) {
        println("Flushing image cache.")
        imageDictionary.removeAll(keepCapacity: false)
    }
}
