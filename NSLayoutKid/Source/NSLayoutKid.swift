import UIKit

public struct NSLayoutKid {
    init() {}
    
    public enum Axis: NSLayoutConstraintAttributeConvertable {
        // X
        case left
        case right
        case centerX
        // Y
        case top
        case bottom
        case centerY
        case lastBaseline
        case firstBaseline
    }
    
    public enum Axes {
        case all
        case top
        case right
        case bottom
        case left
        case horizontal
        case vertical
        case center
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        
        public var axes: [Axis] {
            switch self {
            case .all:
                return [.top, .right, .bottom, .left]
            case .top:
                return [.top, .right, .left]
            case .right:
                return [.top, .right, .bottom]
            case .bottom:
                return [.right, .bottom, .left]
            case .left:
                return [.top, .bottom, .left]
            case .horizontal:
                return [.right, .left]
            case .vertical:
                return [.top, .bottom]
            case .center:
                return [.centerX, .centerY]
            case .topLeft:
                return [.top, .left]
            case .topRight:
                return [.top, .right]
            case .bottomLeft:
                return [.bottom, .left]
            case .bottomRight:
                return [.bottom, .right]
            }
        }
    }
    
    public enum Dimension: NSLayoutConstraintAttributeConvertable {
        case width
        case height
        case notAnAttribute
    }
    
    public enum Dimensions {
        case all
        
        var dimensions: [Dimension] {
            [.width, .height]
        }
    }
}

// MARK: - Axis
extension NSLayoutKid.Axis {
    public var attribute: NSLayoutConstraint.Attribute {
        switch self {
            // X
        case .left:
            return .left
        case .right:
            return .right
        case .centerX:
            return .centerX
            // Y
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .centerY:
            return .centerY
        case .lastBaseline:
            return .lastBaseline
        case .firstBaseline:
            return .firstBaseline
        }
    }
}

// MARK: - Dimension
extension NSLayoutKid.Dimension {
    public var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width:
            return .width
        case .height:
            return .height
        case .notAnAttribute:
            return .notAnAttribute
        }
    }
}
