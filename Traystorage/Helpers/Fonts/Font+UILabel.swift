import Foundation
import UIKit

@IBDesignable
class UIFontLabel: UILabel {
    @IBInspectable var fontFamily: String = "System" {
        didSet {
            self.font = createFont(name: fontFamily, size: fontSize)
        }
    }
    
    @IBInspectable var fontSize: CGFloat = 10.0 {
        didSet {
            self.font = createFont(name: fontFamily, size: fontSize)
        }
    }
    
    @IBInspectable var lineHeight: CGFloat = 1.0 {
        didSet {
            setLineHeight(lineHeight: lineHeight)
        }
    }
}
