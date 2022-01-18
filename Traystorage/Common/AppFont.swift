import Foundation
import SwiftyJSON
import UIKit

class AppFont {
    static func robotoRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size)!
    }
    
    static func robotoBlack(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Black", size: size)!
    }
    
    static func robotoBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
}
