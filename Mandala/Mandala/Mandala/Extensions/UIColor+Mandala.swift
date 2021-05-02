import Foundation
import UIKit

extension UIColor {
    static let angry = UIColor(named: "angryRed")!
    static let confused = UIColor(named: "confusedPurple")!
    static let crying = UIColor(named: "cryingLightBlue")!
    static let goofy = UIColor(named: "goofyOrange")!
    static let happy = UIColor(named: "happyTurquoise")!
    static let meh = UIColor(named: "mehGray")!
    static let sad = UIColor(named: "sadBlue")!
    static let sleepy = UIColor(named: "sleepyLightRed")!
    
    static let colors: [ImageResource: UIColor] = [
        .angry: angry,
        .confused: confused,
        .crying: crying,
        .goofy: goofy,
        .happy: happy,
        .meh: meh,
        .sad: sad,
        .sleepy: sleepy
    ]
}
