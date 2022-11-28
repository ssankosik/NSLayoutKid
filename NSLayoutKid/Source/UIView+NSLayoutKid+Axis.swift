import UIKit

// MARK: - Self
extension UIView {
    // Axis
    @discardableResult
    public func anchor(
        axis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable,
        axis itemAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        anchor(
            attribute: axis,
            relation: axis.getTranslateRelation(with: relation),
            to: item,
            attribute: itemAxis,
            constant: axis.getTranslateConstant(with: constant),
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchor(
        axis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable,
        axis itemAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        getLayoutConstraint(
            axis: axis,
            relation: relation,
            to: item,
            axis: itemAxis)
        .flatMap({
            update(
                layoutConstraint: $0,
                constant: constant.flatMap(axis.getTranslateConstant),
                priority: priority)
            return $0
        })
    }
    
    public func removeAnchor(
        axis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable,
        axis itemAxis: NSLayoutKid.Axis? = nil
    ) {
        getLayoutConstraint(
            axis: axis,
            relation: relation,
            to: item,
            axis: itemAxis)?.isActive = false
    }
}

// MARK: - Superview
extension UIView {
    @discardableResult
    public func anchorToSuperView(
        axis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        axis itemAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        superview.flatMap({
            anchor(
                axis: axis,
                relation: relation,
                to: $0,
                axis: itemAxis,
                constant: constant,
                priority: priority)
        })
    }
    
    @discardableResult
    public func updateAnchorToSuperView(
        axis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        axis itemAxis: NSLayoutKid.Axis? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        superview.flatMap({
            updateAnchor(
                axis: axis,
                relation: relation,
                to: $0,
                axis: itemAxis,
                constant: constant,
                priority: priority)
        })
    }
    
    public func removeAnchorToSuperView(
        axis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        axis itemAxis: NSLayoutKid.Axis? = nil
    ) {
        superview.flatMap({
            getLayoutConstraint(
                axis: axis,
                relation: relation,
                to: $0,
                axis: itemAxis)?.isActive = false
        })
    }
}
