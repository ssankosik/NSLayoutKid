import NSLayoutKid
import UIKit

extension UIApplication {
    var appDelegate: AppDelegate {
        delegate as! AppDelegate
    }
}

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
            if NSClassFromString("XCTest") == nil {
                $0.rootViewController = UINavigationController(rootViewController: ViewController())
                $0.makeKeyAndVisible()
            }
            $0.backgroundColor = .white
        })
        return true
    }
}
