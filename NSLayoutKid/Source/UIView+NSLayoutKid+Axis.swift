import UIKit

// MARK: - Self
extension UILayoutAnchorable {
    @discardableResult
    public func anchor(
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        let toAxis = toAxis ?? fromAxis
        return anchor(
            attribute: fromAxis,
            relation: relation.getTranslated(axis: fromAxis),
            to: toItem,
            attribute: toAxis,
            constant: constant.getTranslated(axis: fromAxis),
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchor(
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil,
        toConstant: CGFloat? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        let toAxis = toAxis ?? fromAxis
        guard
            let result = getLayoutConstraint(
                axis: fromAxis,
                relation: relation,
                to: toItem,
                axis: toAxis,
                constant: constant,
                priority: priority)
        else {
            return nil
        }
        let toConstant = toConstant?.getTranslated(axis: result.isReverse ? fromAxis : toAxis)
        result.layoutConstraint.update(constant: toConstant, priority: toPriority)
        return result.layoutConstraint
    }

    @discardableResult
    public func removeAnchor(
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        let toAxis = toAxis ?? fromAxis
        guard
            let result = getLayoutConstraint(
                axis: fromAxis,
                relation: relation,
                to: toItem,
                axis: toAxis,
                constant: constant,
                priority: priority)
        else {
            return nil
        }
        result.layoutConstraint.isActive = false
        return result.layoutConstraint
    }
}

// MARK: - Superview
extension UIView {
    @discardableResult
    public func anchorToSuperView(
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        axis toAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        return anchor(
            axis: fromAxis,
            relation: relation,
            to: superview,
            axis: toAxis,
            constant: constant,
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchorToSuperView(
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        axis toAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil,
        toConstant: CGFloat? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        return updateAnchor(
            axis: fromAxis,
            relation: relation,
            to: superview,
            axis: toAxis,
            constant: constant,
            priority: priority,
            toConstant: toConstant,
            toPriority: toPriority)
    }
    
    @discardableResult
    public func removeAnchorToSuperView(
        axis fromAxis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        axis toAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        return removeAnchor(
            axis: fromAxis,
            relation: relation,
            to: superview,
            axis: toAxis,
            constant: constant,
            priority: priority)
    }
}
