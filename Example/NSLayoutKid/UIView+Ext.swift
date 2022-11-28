import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner = .allCorners, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = .init(rawValue: corners.rawValue)
    }
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.1,
        cornerRadius: CGFloat = 0,
        offset: CGSize = .init(width: 0, height: 2),
        radius: CGFloat = 3
    ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.cornerRadius = cornerRadius
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius).cgPath
    }
    
    func updateShadowPath() {
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: layer.cornerRadius).cgPath
    }
    
    func anchorToSafeArea(
        viewController: UIViewController,
        anchorTop: Bool = false,
        anchorBottom: Bool = false,
        topInset: CGFloat? = nil,
        bottomInset: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if anchorTop || topInset != nil {
            topAnchor.constraint(
                equalTo: viewController.topSafeAreaAnchor,
                constant: topInset ?? 0).isActive = true
        }
        if anchorBottom || bottomInset != nil {
            topAnchor.constraint(
                equalTo: viewController.bottomSafeAreaAnchor,
                constant: -(bottomInset ?? 0)).isActive = true
        }
    }
}
