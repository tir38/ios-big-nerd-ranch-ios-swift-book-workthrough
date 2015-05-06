
import Foundation
import UIKit

class ImageStore: NSObject {
    
    private var imageDictionary = [String:UIImage]()
    
    func setImage(image: UIImage, forKey key: String) {
        imageDictionary.updateValue(image, forKey: key)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return imageDictionary[key]
    }
    
    func deleteImageForKey(key: String) {
        imageDictionary.removeValueForKey(key)
    }
}
