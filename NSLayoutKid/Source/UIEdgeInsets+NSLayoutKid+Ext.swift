import UIKit

extension UIEdgeInsets {
    public var inset: CGFloat? {
        get {
            (top == left) && (top == bottom) && (top == right) ? top : nil
        }
        
        set {
            guard let newValue = newValue else { return }
            top = newValue
            left = newValue
            bottom = newValue
            right = newValue
        }
    }
    
    public init(
        inset: CGFloat = 0,
        top: CGFloat? = nil,
        left: CGFloat? = nil,
        bottom: CGFloat? = nil,
        right: CGFloat? = nil
    ) {
        self.init(
            top: top ?? inset,
            left: left ?? inset,
            bottom: bottom ?? inset,
            right: right ?? inset)
    }
    
    public var horizontal: CGFloat {
        get {
            left + right
        }
        
        set {
            left = newValue
            right = newValue
        }
    }
    
    public var vertical: CGFloat {
        get {
            top + bottom
        }
        
        set {
            top = newValue
            bottom = newValue
        }
    }
    
    public init(
        horizontal: CGFloat = 0,
        vertical: CGFloat = 0
    ) {
        self.init(
            top: vertical / 2,
            left: horizontal / 2,
            bottom: vertical / 2,
            right: horizontal / 2)
    }
}
