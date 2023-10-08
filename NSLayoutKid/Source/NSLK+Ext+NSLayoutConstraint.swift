import UIKit

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
    func getTranslated(axis: NSLK.Axis) -> NSLayoutConstraint.Relation {
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
