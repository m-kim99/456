import Foundation
import UIKit
import Material

@IBDesignable
class FontTextField: TextField {
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
    
    @IBInspectable var closeButtonOffset: CGFloat = CGFloat.infinity
    
    func textFont() -> UIFont {
        return AppFont.createFont(name: fontFamily, size: fontSize)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        if closeButtonOffset != CGFloat.infinity {
            return rect.offsetBy(dx: -closeButtonOffset, dy: 0)
        }
        
        return rect
    }
}

extension TextField {
    @IBInspectable var xibPlaceholder: String? {
        set(value) {
            super.placeholder = value?._localized
        }
        get {
            return super.placeholder
        }
    }
}
