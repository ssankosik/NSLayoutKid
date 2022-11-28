import UIKit

// MARK: - Self
extension UIView {
    @discardableResult
    public func anchor(
        axes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?] {
        .init(uniqueKeysWithValues: axes.axes.compactMap({
            ($0, anchor(
                axis: $0,
                relation: relation,
                to: item,
                constant: $0.getConstant(from: insets)))
        }))
    }
    
    @discardableResult
    public func updateAnchor(
        axes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?] {
        .init(uniqueKeysWithValues: axes.axes.compactMap({
            ($0, updateAnchor(
                axis: $0,
                relation: relation,
                to: item,
                constant: $0.getConstant(from: insets)))
        }))
    }
    
    public func removeAnchor(
        axes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable
    ) {
        axes.axes.forEach({
            removeAnchor(
                axis: $0,
                relation: relation,
                to: item,
                axis: $0)
        })
    }
}

// MARK: - Superview
extension UIView {
    @discardableResult
    public func anchorToSuperView(
        axes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?]? {
        superview.flatMap({
            anchor(
                axes: axes,
                relation: relation,
                to: $0,
                insets: insets)
        })
    }
    
    @discardableResult
    public func updateAnchorToSuperView(
        axes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutKid.Axis: NSLayoutConstraint?]? {
        superview.flatMap({
            updateAnchor(
                axes: axes,
                relation: relation,
                to: $0,
                insets: insets)
        })
    }
    
    public func removeAnchorToSuperView(
        axes: NSLayoutKid.Axes = .all,
        relation: NSLayoutConstraint.Relation = .equal
    ) {
        superview.flatMap({ view in
            axes.axes.forEach({
                removeAnchor(
                    axis: $0,
                    relation: relation,
                    to: view,
                    axis: $0)
            })
        })
    }
}
