import NSLayoutKid
import UIKit

@UIApplicationMain
class AppDelegate:
    UIResponder,
    UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UINavigationBar.appearance().setup()
        window = UIWindow()
        window.flatMap({
            $0.rootViewController = UINavigationController(rootViewController: ViewController())
            $0.makeKeyAndVisible()
            $0.backgroundColor = .white
        })
        return true
    }
}

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
