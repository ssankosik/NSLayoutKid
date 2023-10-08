import UIKit

public protocol NSLKCompatible: AnyObject {}

extension NSLKCompatible {
    public var nslk: NSLKWrapper<Self> {
        get { return NSLKWrapper(self) }
        set {}
    }
}

extension UIView: NSLKCompatible {}

extension UILayoutGuide: NSLKCompatible {}
