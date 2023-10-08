import UIKit

// MARK: - Self
extension NSLKWrapper where Base: UILayoutAnchorable {
    @discardableResult
    public func anchorDimensions(
        relation: NSLayoutConstraint.Relation = .equal,
        to toItem: UILayoutAnchorable? = nil,
        multiplier: CGFloat = 1,
        size: CGSize = .zero,
        priority: UILayoutPriority = .required
    ) -> [NSLK.Dimension: NSLayoutConstraint?] {
        let result = NSLK.Dimensions.all.dimensions
            .compactMap({
                ($0, self.anchor(
                    dimension: $0,
                    relation: relation,
                    to: toItem,
                    multiplier: multiplier,
                    constant: size.getSide(dimension: $0),
                    priority: priority))
            })
        return .init(uniqueKeysWithValues: result)
    }
    
    @discardableResult
    public func updateAnchorDimensions(
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable? = nil,
        multiplier: CGFloat? = nil,
        size: CGSize? = nil,
        priority: UILayoutPriority? = nil,
        toSize: CGSize? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> [NSLK.Dimension: NSLayoutConstraint?] {
        let result = NSLK.Dimensions.all.dimensions
            .compactMap({
                ($0, self.updateAnchor(
                    dimension: $0,
                    relation: relation,
                    to: toItem,
                    dimension: $0,
                    multiplier: multiplier,
                    constant: size?.getSide(dimension: $0),
                    priority: priority,
                    toConstant: toSize?.getSide(dimension: $0),
                    toPriority: toPriority))
            })
        return .init(uniqueKeysWithValues: result)
    }
    
    @discardableResult
    public func removeAnchorDimensions(
        relation: NSLayoutConstraint.Relation? = nil,
        to toItem: UILayoutAnchorable? = nil,
        multiplier: CGFloat? = nil,
        size: CGSize? = nil,
        priority: UILayoutPriority? = nil
    ) -> [NSLK.Dimension: NSLayoutConstraint?] {
        let result = NSLK.Dimensions.all.dimensions.compactMap({
            ($0, self.removeAnchor(
                dimension: $0,
                relation: relation,
                to: toItem,
                dimension: $0,
                multiplier: multiplier,
                constant: size?.getSide(dimension: $0),
                priority: priority))
        })
        return .init(uniqueKeysWithValues: result)
    }
}

// MARK: - Superview
extension NSLKWrapper where Base: UILayoutAnchorable {
    @discardableResult
    public func anchorToSuperViewDimensions(
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        size: CGSize = .zero,
        priority: UILayoutPriority = .required
    ) -> [NSLK.Dimension: NSLayoutConstraint?]? {
        guard let superview = base.getSuperview() else { return nil }
        return anchorDimensions(
            relation: relation,
            to: superview,
            multiplier: multiplier,
            size: size,
            priority: priority)
    }
    
    @discardableResult
    public func updateAnchorToSuperViewDimensions(
        relation: NSLayoutConstraint.Relation? = nil,
        multiplier: CGFloat? = nil,
        size: CGSize? = nil,
        priority: UILayoutPriority? = nil,
        toSize: CGSize? = nil,
        toPriority: UILayoutPriority? = nil
    ) -> [NSLK.Dimension: NSLayoutConstraint?]? {
        guard let superview = base.getSuperview() else { return nil }
        return updateAnchorDimensions(
            relation: relation,
            to: superview,
            multiplier: multiplier,
            size: size,
            priority: priority,
            toSize: toSize,
            toPriority: toPriority)
    }
    
    @discardableResult
    public func removeAnchorDimensionsToSuperView(
        relation: NSLayoutConstraint.Relation? = nil,
        multiplier: CGFloat? = nil,
        size: CGSize? = nil,
        priority: UILayoutPriority? = nil
    ) -> [NSLK.Dimension: NSLayoutConstraint?]? {
        guard let superview = base.getSuperview() else { return nil }
        return removeAnchorDimensions(
            relation: relation,
            to: superview,
            multiplier: multiplier,
            size: size,
            priority: priority)
    }
}
