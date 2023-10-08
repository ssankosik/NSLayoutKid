import UIKit

extension CGFloat {
    func getTranslated(axis: NSLK.Axis) -> CGFloat {
        switch axis {
        case .right,
             .bottom:
            return -self
        default:
            return self
        }
    }
}
