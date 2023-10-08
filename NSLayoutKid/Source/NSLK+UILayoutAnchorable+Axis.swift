import UIKit

// MARK: - Self
extension NSLKWrapper where Base: UILayoutAnchorable {
    @discardableResult
    public func anchor(
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLK.Axis? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        let toAxis = toAxis ?? fromAxis
        return base.anchor(
            attribute: fromAxis,
            relation: relation.getTranslated(axis: fromAxis),
            to: toItem,
            attribute: toAxis,
            constant: constant.getTranslated(axis: fromAxis),
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchor(
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLK.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil,
        toConstant: CGFloat? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        let toAxis = toAxis ?? fromAxis
        guard
            let result = base.getConstraint(
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
        result.constraint.update(constant: toConstant, priority: toPriority)
        return result.constraint
    }

    @discardableResult
    public func removeAnchor(
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable,
        axis toAxis: NSLK.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        let toAxis = toAxis ?? fromAxis
        guard
            let result = base.getConstraint(
                axis: fromAxis,
                relation: relation,
                to: toItem,
                axis: toAxis,
                constant: constant,
                priority: priority)
        else {
            return nil
        }
        result.constraint.isActive = false
        return result.constraint
    }
}

// MARK: - Superview
extension NSLKWrapper where Base: UILayoutAnchorable {
    @discardableResult
    public func anchorToSuperView(
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        axis toAxis: NSLK.Axis? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        guard let superview = base.getSuperview() else { return nil }
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
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        axis toAxis: NSLK.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil,
        toConstant: CGFloat? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        guard let superview = base.getSuperview() else { return nil }
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
        axis fromAxis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation? = nil,
        axis toAxis: NSLK.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        guard let superview = base.getSuperview() else { return nil }
        return removeAnchor(
            axis: fromAxis,
            relation: relation,
            to: superview,
            axis: toAxis,
            constant: constant,
            priority: priority)
    }
}
