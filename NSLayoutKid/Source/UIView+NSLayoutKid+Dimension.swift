import UIKit

// MARK: - Self
extension UIView {
    @discardableResult
    public func anchor(
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        to toItem: UILayoutAnchorable? = nil,
        dimension toDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        let toDimension = toItem.isNotNil ? toDimension ?? fromDimension : .notAnAttribute
        return anchor(
            attribute: fromDimension,
            relation: relation,
            to: toItem,
            attribute: toDimension,
            multiplier: multiplier,
            constant: constant,
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchor(
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable? = nil,
        dimension toDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil,
        toConstant: CGFloat? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        let toDimension = toItem.isNotNil ? toDimension ?? fromDimension : .notAnAttribute
        guard
            let result = getLayoutConstraint(
                dimension: fromDimension,
                relation: relation,
                to: toItem,
                dimension: toDimension,
                multiplier: multiplier,
                constant: constant,
                priority: priority)
        else {
            return nil
        }
        result.update(constant: toConstant, priority: toPriority)
        return result
    }
    
    @discardableResult
    public func removeAnchor(
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable? = nil,
        dimension toDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        let toDimension = toItem.isNotNil ? toDimension ?? fromDimension : .notAnAttribute
        guard
            let result = getLayoutConstraint(
                dimension: fromDimension,
                relation: relation,
                to: toItem,
                dimension: toDimension,
                multiplier: multiplier,
                constant: constant,
                priority: priority)
        else {
            return nil
        }
        result.isActive = false
        return result
    }
}

// MARK: - Superview
extension UIView {
    @discardableResult
    public func anchorToSuperView(
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        dimension toDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        return anchor(
            dimension: fromDimension,
            relation: relation,
            to: superview,
            dimension: toDimension,
            multiplier: multiplier,
            constant: constant,
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchorToSuperView(
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation? = nil,
        dimension toDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil,
        toConstant: CGFloat? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        return updateAnchor(
            dimension: fromDimension,
            relation: relation,
            to: superview,
            dimension: toDimension,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            toConstant: toConstant,
            toPriority: toPriority)
    }
    
    @discardableResult
    public func removeAnchorToSuperView(
        dimension fromDimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation? = nil,
        dimension toDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        return removeAnchor(
            dimension: fromDimension,
            relation: relation,
            to: superview,
            dimension: toDimension,
            multiplier: multiplier,
            constant: constant,
            priority: priority)
    }
}
