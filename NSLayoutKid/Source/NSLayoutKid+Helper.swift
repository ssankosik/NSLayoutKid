import UIKit

protocol Apply {}
extension Apply where Self: Any {
  @discardableResult
  func apply(_ block: ((Self) throws -> Void)) rethrows -> Self {
    try block(self)
    return self
  }
}

extension NSObject: Apply {}

extension Array: Apply {}
extension Dictionary: Apply {}
extension Set: Apply {}

extension Optional {
    var isNil: Bool { self == nil }
    
    var isNotNil: Bool { self != nil }
}

extension NSLayoutConstraint {
    private func getView(item: AnyObject?) -> UIView? {
        guard let item = item as? UILayoutAnchorable else { return nil }
        switch item {
        case let item as UIView:
            return item
        case let item as UILayoutGuide:
            return item.owningView
        default:
            return nil
        }
    }
    
    var firstView: UIView? {
        getView(item: firstItem)
    }

    var secondView: UIView? {
        getView(item: secondItem)
    }
}
