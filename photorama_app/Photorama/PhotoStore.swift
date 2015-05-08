

import Foundation

class PhotoStore {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentPhotos() {
        
        if let url = FlickrAPI.recentPhotosURL() {

            let request = NSURLRequest(URL: url)
            
            // create task
            let task = session.dataTaskWithRequest(request, completionHandler: { // second arg is a closure that acts as completion handler
                (data, response, error) -> Void in
                
                if let jsonData = data {
                    if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) {
                        println("\(jsonString)")
                    }
                } else if let requestError = error {
                    println("Error fetching recent photos: \(requestError.localizedDescription)")
                } else {
                    println("Unexpected error with request")
                }
            })
            
            task.resume() // start task
        }
    }
}
