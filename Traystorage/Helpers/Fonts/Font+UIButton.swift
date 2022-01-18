import Foundation
import UIKit

@IBDesignable
class UIFontButton: UIButton {
    @IBInspectable var fontFamily: String = "System" {
        didSet {
            self.titleLabel?.font = createFont(name: fontFamily, size: fontSize)
        }
    }
    
    @IBInspectable var fontSize: CGFloat = 10.0 {
        didSet {
            self.titleLabel?.font = createFont(name: fontFamily, size: fontSize)
        }
    }
}
