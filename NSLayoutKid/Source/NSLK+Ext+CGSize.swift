import UIKit

extension CGSize {
    public init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}

extension CGSize {
    func getSide(dimension: NSLK.Dimension) -> CGFloat {
        switch dimension {
        case .width:
            return width
        case .height:
            return height
        default:
            return 0
        }
    }
}
