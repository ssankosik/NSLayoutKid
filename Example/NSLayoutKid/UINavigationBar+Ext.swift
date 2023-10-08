import UIKit

extension UINavigationBar {
    @available(iOS 13.0, *)
    private func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = titleTextAttributes ?? [:]
        appearance.backgroundColor = barTintColor
        // tintColor
        appearance.backgroundImage = backgroundImage(for: .default)
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
    
    func setup(
        titleColor: UIColor = .black,
        buttonColor: UIColor = .black,
        backgroundColor: UIColor = .grey02
    ) {
        titleTextAttributes = [
            .foregroundColor: titleColor
        ]
        tintColor = buttonColor
        barTintColor = backgroundColor
        setBackgroundImage(.init(), for: .default)
        shadowImage = .init()
        if #available(iOS 13.0, *) {
            setupAppearance()
        }
    }
}
