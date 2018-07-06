
import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    
    // MARK: - Properties
    var textFont = UIFont(name: "Montserrat-Regular", size: 20.0)
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
       
        if let fnt = textFont {
            self.font = fnt 
        } else {
            self.font = UIFont(name: "Helvetica Neue", size: 17.0)
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}
