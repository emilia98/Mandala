import UIKit

struct Mood {
    var name: String
    var image: UIImage
    var color: UIColor
    
    static let colors: [ImageResource: UIColor] = ImageResource.allCases.reduce(into: [:]) {
        $0[$1] = UIColor(named: $1.rawValue)
    }
    
    init(_ resource: ImageResource) {
        self.name = resource.rawValue
        self.image = UIImage(resource: resource)
        self.color = Self.colors[resource]!
    }
    
    static let angry = Mood(.angry)
    static let confused = Mood(.confused)
    static let crying = Mood(.crying)
    static let goofy = Mood(.goofy)
    static let happy = Mood(.happy)
    static let meh = Mood(.meh)
    static let sad = Mood(.sad)
    static let sleepy = Mood(.sleepy)
}
