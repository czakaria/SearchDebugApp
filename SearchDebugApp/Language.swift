

import Foundation

class Language: NSObject {
    var language: String?
    var subname: String?
    
    
    init(dictionary: [String: Any]) {
        self.language = dictionary["language"] as? String
        self.subname = dictionary["subname"] as? String
        
    }
    
}
