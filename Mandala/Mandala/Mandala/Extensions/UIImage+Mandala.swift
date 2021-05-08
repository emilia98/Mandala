import UIKit

enum ImageResource: String, CaseIterable {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    convenience init(resource: ImageResource) {
        print(resource.rawValue)
        self.init(named: resource.rawValue)!
    }
}
