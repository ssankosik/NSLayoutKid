import UIKit

// MARK: - Scope + Apply
protocol Apply {}
extension Apply where Self: Any {
  @discardableResult
  func apply(_ block: ((Self) throws -> Void)) rethrows -> Self {
    try block(self)
    return self
  }
}

extension NSObject: Apply {}

extension Array: Apply {}
extension Dictionary: Apply {}
extension Set: Apply {}

extension Optional {
    var isNil: Bool { self == nil }
    
    var isNotNil: Bool { self != nil }
}

// MARK: - NSLayoutConstraint + Ext
extension NSLayoutConstraint {
    private func getView(item: AnyObject?) -> UIView? {
        switch item {
        case let item as UIView:
            return item
        case let item as UILayoutGuide:
            return item.owningView
        default:
            return nil
        }
    }
    
    var firstView: UIView? {
        getView(item: firstItem)
    }

    var secondView: UIView? {
        getView(item: secondItem)
    }

    func update(
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) {
        if let constant = constant {
            self.constant = constant
        }
        if let priority = priority {
            self.priority = priority
        }
    }
}

extension NSLayoutConstraint.Attribute {
    var safeAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .leading:
            return .left
        case .trailing:
            return .right
        default:
            return self
        }
    }
}

extension NSLayoutConstraint.Relation {
    func getTranslated(axis: NSLayoutKid.Axis) -> NSLayoutConstraint.Relation {
        switch axis {
        case .right,
             .bottom:
            switch self {
            case .lessThanOrEqual:
                return .greaterThanOrEqual
            case .equal:
                return self
            case .greaterThanOrEqual:
                return .lessThanOrEqual
            @unknown default:
                return self
            }
        default:
            return self
        }
    }
}

// MARK: - UIEdgeInsets + Ext
extension UIEdgeInsets {
    func getInset(axis: NSLayoutKid.Axis) -> CGFloat {
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

// MARK: - CGFloat + Ext
extension CGFloat {
    func getTranslated(axis: NSLayoutKid.Axis) -> CGFloat {
        switch axis {
        case .right,
             .bottom:
            return -self
        default:
            return self
        }
    }
}

// MARK: - CGSize + Ext
extension CGSize {
    func getSide(dimension: NSLayoutKid.Dimension) -> CGFloat {
        switch dimension {
        case .width:
            return width
        case .height:
            return height
        case .notAnAttribute:
            return 0
        }
    }
}
