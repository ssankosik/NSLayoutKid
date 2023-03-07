import UIKit

// MARK: - Self
extension UILayoutAnchorable {
    @discardableResult
    public func anchor(
        axes fromAxes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal,
        to toItem: UILayoutAnchorable,
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?] {
        let result = fromAxes.axes
            .compactMap({
                ($0, self.anchor(
                    axis: $0,
                    relation: relation,
                    to: toItem,
                    constant: insets.getInset(axis: $0),
                    priority: priority))
            })
        return .init(uniqueKeysWithValues: result)
    }
    
    @discardableResult
    public func updateAnchor(
        axes fromAxes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable,
        insets: UIEdgeInsets? = nil,
        priority: UILayoutPriority? = nil,
        toInsets: UIEdgeInsets? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?] {
        let result = fromAxes.axes.compactMap({
            ($0, self.updateAnchor(
                axis: $0,
                relation: relation,
                to: toItem,
                constant: insets?.getInset(axis: $0),
                priority: priority,
                toConstant: toInsets?.getInset(axis: $0),
                toPriority: toPriority))
        })
        return .init(uniqueKeysWithValues: result)
    }
    
    @discardableResult
    public func removeAnchor(
        axes fromAxes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable,
        insets: UIEdgeInsets? = nil,
        priority: UILayoutPriority? = nil
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?] {
        let result = fromAxes.axes.compactMap({
            ($0, self.removeAnchor(
                axis: $0,
                relation: relation,
                to: toItem,
                constant: insets?.getInset(axis: $0),
                priority: priority))
        })
        return .init(uniqueKeysWithValues: result)
    }
}

// MARK: - Superview
extension UIView {
    @discardableResult
    public func anchorToSuperView(
        axes fromAxes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal,
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?]? {
        guard let superview = superview else { return nil }
        return anchor(
            axes: fromAxes,
            relation: relation,
            to: superview,
            insets: insets,
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchorToSuperView(
        axes fromAxes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation? = nil,
        insets: UIEdgeInsets? = nil,
        priority: UILayoutPriority? = nil,
        toInsets: UIEdgeInsets? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?]? {
        guard let superview = superview else { return nil }
        return updateAnchor(
            axes: fromAxes,
            relation: relation,
            to: superview,
            insets: insets,
            priority: priority,
            toInsets: toInsets,
            toPriority: toPriority)
    }
    
    @discardableResult
    public func removeAnchorToSuperView(
        axes fromAxes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation? = nil,
        insets: UIEdgeInsets? = nil,
        priority: UILayoutPriority? = nil
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?]? {
        guard let superview = superview else { return nil }
        return removeAnchor(
            axes: fromAxes,
            relation: relation,
            to: superview,
            insets: insets,
            priority: priority)
    }
}
