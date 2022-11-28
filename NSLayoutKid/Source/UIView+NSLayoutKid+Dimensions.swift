import UIKit

// MARK: - Self
extension UIView {
    @discardableResult
    public func anchorDimensions(
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable? = nil,
        multiplier: CGFloat = 1,
        size: CGSize = .zero,
        priority: UILayoutPriority = .required
    ) -> [NSLayoutKid.Dimension: NSLayoutConstraint?] {
        .init(uniqueKeysWithValues: NSLayoutKid.Dimensions.all.dimensions.compactMap({
            ($0, anchor(
                dimension: $0,
                to: item,
                multiplier: multiplier,
                constant: $0.getConstant(from: size),
                priority: priority))
        }))
    }
    
    @discardableResult
    public func updateAnchorDimensions(
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable? = nil,
        size: CGSize? = nil,
        priority: UILayoutPriority? = nil
    ) -> [NSLayoutKid.Dimension: NSLayoutConstraint?] {
        .init(uniqueKeysWithValues: NSLayoutKid.Dimensions.all.dimensions.compactMap({ dimension in
            (dimension, updateAnchor(
                dimension: dimension,
                relation: relation,
                to: item,
                constant: size.flatMap(dimension.getConstant),
                priority: priority))
        }))
    }
    
    public func removeAnchorDimensions<Item: UILayoutAnchorable>(
        relation: NSLayoutConstraint.Relation = .equal,
        to item: Item? = nil
    ) {
        NSLayoutKid.Dimensions.all.dimensions.forEach({
            removeAnchor(
                dimension: $0,
                relation: relation,
                to: item,
                dimension: $0)
        })
    }
}

// MARK: - Superview
extension UIView {
    @discardableResult
    public func anchorToSuperViewDimensions(
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        size: CGSize = .zero,
        priority: UILayoutPriority = .required
    ) -> [NSLayoutKid.Dimension: NSLayoutConstraint?]? {
        superview.flatMap({
            anchorDimensions(
                relation: relation,
                to: $0,
                multiplier: multiplier,
                size: size,
                priority: priority)
        })
    }
    
    @discardableResult
    public func updateAnchorToSuperViewDimensions(
        relation: NSLayoutConstraint.Relation = .equal,
        size: CGSize? = nil,
        priority: UILayoutPriority? = nil
    ) -> [NSLayoutKid.Dimension: NSLayoutConstraint?]? {
        superview.flatMap({
            updateAnchorDimensions(
                relation: relation,
                to: $0,
                size: size,
                priority: priority)
        })
    }
    
    public func removeAnchorDimensionsToSuperView(
        relation: NSLayoutConstraint.Relation = .equal
    ) {
        superview.flatMap({
            removeAnchorDimensions(
                relation: relation,
                to: $0)
        })
    }
}
