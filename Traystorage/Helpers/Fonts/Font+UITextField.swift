import Foundation
import UIKit

@IBDesignable
class UIFontTextField: UITextField {
    @IBInspectable var fontFamily: String = AppFont.fontFamilyName {
        didSet {
            self.font = textFont()
        }
    }
    
    @IBInspectable var fontSize: CGFloat = 15.0 {
        didSet {
            self.font = textFont()
        }
    }
    
    func textFont() -> UIFont {
        return AppFont.createFont(name: fontFamily, size: fontSize)
    }
    
}
