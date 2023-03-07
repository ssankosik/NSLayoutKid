import UIKit

// MARK: - Core
extension UILayoutAnchorable {
    @discardableResult
    func anchor(
        attribute fromAttribute: NSLayoutConstraintAttributeConvertable,
        relation: NSLayoutConstraint.Relation = .equal,
        to toItem: UILayoutAnchorable? = nil,
        attribute toAttribute: NSLayoutConstraintAttributeConvertable,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraint: NSLayoutConstraint = .init(
            item: self,
            attribute: fromAttribute.attribute,
            relatedBy: relation,
            toItem: toItem,
            attribute: toAttribute.attribute,
            multiplier: multiplier,
            constant: constant)
        layoutConstraint.priority = priority
        layoutConstraint.isActive = true
        return layoutConstraint
    }
    
    private var view: UIView? {
        switch self {
        case let item as UIView:
            return item
        case let item as UILayoutGuide:
            return item.owningView
        default:
            return nil
        }
    }
    
    private var sourceView: UIView? {
        switch self {
        case let view as UIView:
            return view.superview
        case let view as UILayoutGuide:
            return view.owningView
        default:
            return nil
        }
    }
}

// MARK: - Axis
extension UILayoutAnchorable {
    private func getLayoutConstraint(
        from fromItem: UILayoutAnchorable,
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLayoutKid.Axis,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> (layoutConstraint: NSLayoutConstraint, isReverse: Bool)? {
        guard let view = sourceView else { return nil }
        let fromView = fromItem.view
        let toView = toItem.view
        let fromAttribute = fromAxis.attribute
        let toAttribute = toAxis.attribute
        for constraint in view.constraints {
            guard
                let firstView = constraint.firstView,
                let secondView = constraint.secondView
            else {
                continue
            }
            if let relation = relation, constraint.relation != relation {
                continue
            }
            if let constant = constant, constraint.constant != constant {
                continue
            }
            if let priority = priority, constraint.priority != priority {
                continue
            }
            let firstAttribute = constraint.firstAttribute.safeAttribute
            let secondAttribute = constraint.secondAttribute.safeAttribute
            if firstView == fromView,
                firstAttribute == fromAttribute,
                secondView == toView,
                secondAttribute == toAttribute {
                return (constraint, true)
            } else if firstView == toView,
                firstAttribute == toAttribute,
                secondView == fromView,
                secondAttribute == fromAttribute {
                return (constraint, false)
            } else {
                continue
            }
        }
        return nil
    }
    
    public func getLayoutConstraint(
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLayoutKid.Axis,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> (layoutConstraint: NSLayoutConstraint, isReverse: Bool)? {
        for view in [self, toItem] {
            if let result = view.getLayoutConstraint(
                from: self,
                axis: fromAxis,
                relation: relation,
                to: toItem,
                axis: toAxis,
                constant: constant,
                priority: priority
            ) {
                return result
            } else {
                continue
            }
        }
        return nil
    }
}

// MARK: - Dimension
extension UILayoutAnchorable {
    private func getLayoutConstraint(
        from fromItem: UILayoutAnchorable,
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable? = nil,
        dimension toDimension: NSLayoutKid.Dimension,
        multiplier: CGFloat?,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> NSLayoutConstraint? {
        guard let view = toItem.isNotNil ? sourceView : view else { return nil }
        let fromView = fromItem.view
        let toView = toItem?.view
        let fromAttribute = fromDimension.attribute
        let toAttribute = (toItem.isNotNil ? toDimension.attribute : .notAnAttribute)
        for constraint in view.constraints {
            guard
                let firstView = constraint.firstView,
                toItem.isNotNil ? constraint.secondView.isNotNil : true
            else {
                continue
            }
            if let relation = relation, constraint.relation != relation {
                continue
            }
            if let multiplier = multiplier, constraint.multiplier != multiplier {
                continue
            }
            if let constant = constant, constraint.constant != constant {
                continue
            }
            if let priority = priority, constraint.priority != priority {
                continue
            }
            let secondView = constraint.secondView
            let firstAttribute = constraint.firstAttribute
            let secondAttribute = constraint.secondAttribute
            if firstView == fromView,
               firstAttribute == fromAttribute,
               secondView == toView,
               secondAttribute == toAttribute {
                return constraint
            } else if
                firstView == toView,
                firstAttribute == toAttribute,
                secondView == fromView,
                secondAttribute == fromAttribute {
                return constraint
            } else {
                continue
            }
        }
        return nil
    }

    public func getLayoutConstraint(
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable? = nil,
        dimension toDimension: NSLayoutKid.Dimension,
        multiplier: CGFloat?,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> NSLayoutConstraint? {
        var items: [UILayoutAnchorable] = [self]
        if let item = toItem {
            items.append(item)
        }
        for view in items {
            if let result = view.getLayoutConstraint(
                from: self,
                dimension: fromDimension,
                relation: relation,
                to: toItem,
                dimension: toDimension,
                multiplier: multiplier,
                constant: constant,
                priority: priority
            ) {
                return result
            } else {
                continue
            }
        }
        return nil
    }
}
