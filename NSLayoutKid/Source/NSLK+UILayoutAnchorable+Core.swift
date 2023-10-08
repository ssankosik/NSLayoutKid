import UIKit

// MARK: - Core
extension UILayoutAnchorable {
    func getView() -> UIView? {
        switch self {
        case let item as UIView:
            return item
        case let item as UILayoutGuide:
            return item.owningView
        default:
            return nil
        }
    }
    
    func getSuperview() -> UIView? {
        getView()?.superview
    }
    
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
        getView()?.translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint = .init(
            item: self,
            attribute: fromAttribute.attribute,
            relatedBy: relation,
            toItem: toItem,
            attribute: toAttribute.attribute,
            multiplier: multiplier,
            constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}

// MARK: - Axis
extension UILayoutAnchorable {
    private func getConstraint(
        from fromItem: UILayoutAnchorable,
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLK.Axis,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> (constraint: NSLayoutConstraint, isReverse: Bool)? {
        guard let view = getSuperview() else { return nil }
        let fromView = fromItem.getView()
        let toView = toItem.getView()
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
    
    public func getConstraint(
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLK.Axis,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> (constraint: NSLayoutConstraint, isReverse: Bool)? {
        for view in [self, toItem] {
            if let result = view.getConstraint(
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
    private func getConstraint(
        from fromItem: UILayoutAnchorable,
        dimension fromDimension: NSLK.Dimension,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable? = nil,
        dimension toDimension: NSLK.Dimension,
        multiplier: CGFloat?,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> NSLayoutConstraint? {
        guard let view = toItem.isNotNil ? getSuperview() : getView() else { return nil }
        let fromView = fromItem.getView()
        let toView = toItem?.getView()
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

    public func getConstraint(
        dimension fromDimension: NSLK.Dimension,
        relation: NSLayoutConstraint.Relation?,
        to toItem: UILayoutAnchorable? = nil,
        dimension toDimension: NSLK.Dimension,
        multiplier: CGFloat?,
        constant: CGFloat?,
        priority: UILayoutPriority?
    ) -> NSLayoutConstraint? {
        var items: [UILayoutAnchorable] = [self]
        if let item = toItem {
            items.append(item)
        }
        for view in items {
            if let result = view.getConstraint(
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
