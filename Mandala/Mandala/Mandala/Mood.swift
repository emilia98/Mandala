import UIKit

struct Mood {
    var name: String
    var image: UIImage
    var color: UIColor
    
    init(_ resource: ImageResource) {
        self.name = resource.rawValue
        self.image = UIImage(resource: resource)
        self.color = UIColor.colors[resource]!
    }
}

extension Mood {
    static let angry = Mood(.angry)
    static let confused = Mood(.confused)
    static let crying = Mood(.crying)
    static let goofy = Mood(.goofy)
    static let happy = Mood(.happy)
    static let meh = Mood(.meh)
    static let sad = Mood(.sad)
    static let sleepy = Mood(.sleepy)
}
