import UIKit

extension Array where Element == CGFloat {
    var isAllEqual: Bool {
        self.min() == self.max()
    }
}
