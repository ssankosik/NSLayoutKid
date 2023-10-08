import UIKit

extension UIEdgeInsets {
    public var inset: CGFloat? {
        get {
            [top, left, bottom, right].isAllEqual ? top : nil
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
    
    public var x: CGFloat? {
        get {
            [left, right].isAllEqual ? left : nil
        }
        
        set {
            guard let newValue = newValue else { return }
            left = newValue
            right = newValue
        }
    }
    
    public var y: CGFloat? {
        get {
            [top, bottom].isAllEqual ? top : nil
        }
        
        set {
            guard let newValue = newValue else { return }
            top = newValue
            bottom = newValue
        }
    }
    
    public init(
        x: CGFloat = 0,
        y: CGFloat = 0
    ) {
        self.init(
            top: y,
            left: x,
            bottom: y,
            right: x)
    }
}

extension UIEdgeInsets {
    func getInset(axis: NSLK.Axis) -> CGFloat {
        switch axis {
        case .top:
            return top
        case .right:
            return right
        case .bottom:
            return bottom
        case .left:
            return left
        default:
            return 0
        }
    }
}
