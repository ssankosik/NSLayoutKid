import UIKit

extension UIEdgeInsets {
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    static func create(
        inset: CGFloat = 0,
        top: CGFloat? = nil,
        left: CGFloat? = nil,
        bottom: CGFloat? = nil,
        right: CGFloat? = nil
    ) -> UIEdgeInsets {
        .init(
            top: top ?? inset,
            left: left ?? inset,
            bottom: bottom ?? inset,
            right: right ?? inset)
    }
    
    var horizontal: CGFloat {
        get {
            left + right
        }
        
        set {
            left = newValue
            right = newValue
        }
    }
    
    var vertical: CGFloat {
        get {
            top + bottom
        }
        
        set {
            top = newValue
            bottom = newValue
        }
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical / 2, left: horizontal / 2, bottom: vertical / 2, right: horizontal / 2)
    }
    
    static func create(
        horizontal: CGFloat = 0,
        vertical: CGFloat = 0
    ) -> UIEdgeInsets {
        .init(
            horizontal: horizontal,
            vertical: vertical)
    }
}
