

import Foundation

class UrlHelper {
    
    static func urlForKey(key: String) -> NSURL {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first as! NSURL
        return documentDirectory.URLByAppendingPathComponent(key)
    }
}
