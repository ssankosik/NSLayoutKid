import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis) {
        self.init()
        self.axis = axis
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func insertArrangedSubviews(_ views: [UIView], at index: Int) {
        for item in views.enumerated() {
            insertArrangedSubview(item.element, at: index + item.offset)
        }
    }
    
    func insertArrangedSubviews(_ views: [UIView], after view: UIView) {
        guard let index = arrangedSubviews.firstIndex(of: view) else { return }
        for item in views.enumerated() {
            insertArrangedSubview(item.element, at: index + item.offset)
        }
    }
    
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
