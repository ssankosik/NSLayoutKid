import UIKit

public struct NSLKWrapper<Base> {
    public let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}
