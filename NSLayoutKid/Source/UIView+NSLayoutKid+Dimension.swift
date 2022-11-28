import UIKit

// MARK: - Self
extension UIView {
    @discardableResult
    public func anchor(
        dimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable? = nil,
        dimension itemDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        anchor(
            attribute: dimension,
            relation: relation,
            to: item,
            attribute: itemDimension,
            multiplier: multiplier,
            constant: constant,
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchor(
        dimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable? = nil,
        dimension itemDimension: NSLayoutKid.Dimension? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        getLayoutConstraint(
            dimension: dimension.attribute,
            relation: relation,
            to: item,
            dimension: itemDimension?.attribute)
        .flatMap({
            update(
                layoutConstraint: $0,
                constant: constant,
                priority: priority)
            return $0
        })
    }
    
    public func removeAnchor(
        dimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable? = nil,
        dimension itemDimension: NSLayoutKid.Dimension? = nil
    ) {
        getLayoutConstraint(
            dimension: dimension.attribute,
            relation: relation,
            to: item,
            dimension: itemDimension?.attribute)?.isActive = false
    }
}

// MARK: - Superview
extension UIView {
    @discardableResult
    public func anchorToSuperView(
        dimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        dimension itemDimension: NSLayoutKid.Dimension? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        superview.flatMap({
            anchor(
                dimension: dimension,
                relation: relation,
                to: $0,
                dimension: itemDimension,
                multiplier: multiplier,
                constant: constant,
                priority: priority)
        })
    }
    
    @discardableResult
    public func updateAnchorToSuperView(
        dimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        dimension itemDimension: NSLayoutKid.Dimension? = nil,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) -> NSLayoutConstraint? {
        superview.flatMap({
            updateAnchor(
                dimension: dimension,
                relation: relation,
                to: $0,
                dimension: itemDimension,
                constant: constant,
                priority: priority)
        })
    }
    
    public func removeAnchorToSuperView(
        dimension: NSLayoutKid.Dimension,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable? = nil,
        dimension itemDimension: NSLayoutKid.Dimension? = nil
    ) {
        superview.flatMap({
            getLayoutConstraint(
                dimension: dimension.attribute,
                relation: relation,
                to: $0,
                dimension: itemDimension?.attribute)
        })?.isActive = false
    }
}
