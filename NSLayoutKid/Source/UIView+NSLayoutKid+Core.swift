import UIKit

extension UIView {
    @discardableResult
    func anchor<T: NSLayoutConstraintAttributeConvertable>(
        attribute: T,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable? = nil,
        attribute itemAttribute: T? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        return .init(
            item: self,
            attribute: attribute.attribute,
            relatedBy: relation,
            toItem: item,
            attribute: item == nil ? .notAnAttribute : itemAttribute?.attribute ?? attribute.attribute,
            multiplier: multiplier,
            constant: constant)
        .apply({
            $0.priority = priority
            $0.isActive = true
        })
    }
    
    func update(
        layoutConstraint: NSLayoutConstraint,
        constant: CGFloat? = nil,
        priority: UILayoutPriority? = nil
    ) {
        if let constant = constant {
            layoutConstraint.constant = constant
        }
        if let priority = priority {
            layoutConstraint.priority = priority
        }
    }
}

extension UIView {
    private func getView(item: UILayoutAnchorable) -> UIView? {
        switch item {
        case let item as UIView:
            return item
        case let item as UILayoutGuide:
            return item.owningView
        default:
            return nil
        }
    }
    
    public func getLayoutConstraint(
        axis: NSLayoutKid.Axis,
        relation: NSLayoutConstraint.Relation = .equal,
        to item: UILayoutAnchorable,
        axis itemAxis: NSLayoutKid.Axis? = nil
    ) -> NSLayoutConstraint? {
        var attributes: [NSLayoutConstraint.Attribute] = [axis.attribute]
        switch axis {
        case .right:
            attributes += [.trailing]
        case .left:
            attributes += [.leading]
        default:
            break
        }
        return attributes
            .compactMap({ attribute in
                superview.flatMap({ superview in
                    superview.constraints.first(where: { constraint in
                        guard
                            let firstView = constraint.firstView,
                            let secondView = constraint.secondView
                        else {
                            return false
                        }
                        let views: [UIView] = [self, item].compactMap({ getView(item: $0) })
                        return views.contains(firstView)
                            && constraint.firstAttribute == attribute
                            && constraint.relation == relation
                            && views.contains(secondView)
                            && constraint.secondAttribute == itemAxis?.attribute ?? attribute
                    })
                })
            })
            .first
    }
    
    public func getLayoutConstraint(
        dimension: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation,
        to item: UILayoutAnchorable? = nil,
        dimension itemDimension: NSLayoutConstraint.Attribute? = nil
    ) -> NSLayoutConstraint? {
        (item.isNotNil ? superview : self).flatMap({
            $0.constraints.first(where: { constraint in
                constraint.firstView == self
                    && constraint.firstAttribute == dimension
                    && constraint.relation == relation
                && constraint.secondView == item.flatMap({ getView(item: $0)  })
                    && constraint.secondAttribute == (item.isNotNil ? itemDimension ?? dimension : .notAnAttribute)
            })
        })
    }
}
