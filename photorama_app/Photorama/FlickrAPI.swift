
import Foundation

enum  Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

private let baseURLString = "https://api.flickr.com/services/rest"
private let APIKey = "a6d819499131071f158fd740860a5a88"

class FlickrAPI {

    private class func flickrURL(#method: Method, parameters: [String:String]?) -> NSURL? {

        if let components = NSURLComponents(string: baseURLString) {
            var queryItems = [NSURLQueryItem]()
            
            var baseParams = [
                "method": method.rawValue,
                "format": "json",
                "nojsoncallback": "1",
                "api_key": APIKey
                ]
            
            for (key, value) in baseParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }

            
            if let additionalParams = parameters {
                for (key, value) in additionalParams {
                    let item = NSURLQueryItem(name: key, value: value)
                    queryItems.append(item)
                }
            }
            
            components.queryItems = queryItems
            return components.URL
        }
        return nil
    }
    
    class func recentPhotosURL() -> NSURL? {
        return flickrURL(method: .RecentPhotos, parameters: ["extras": "url_h,date_taken"])
    }
    
}
