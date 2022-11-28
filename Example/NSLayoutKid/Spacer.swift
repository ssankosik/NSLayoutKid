import UIKit

class Spacer: UIView {
    convenience init(height: CGFloat, relation: NSLayoutConstraint.Relation = .equal) {
        self.init(frame: .zero)
        anchor(dimension: .height, relation: relation, constant: height)
    }
    
    convenience init(width: CGFloat, relation: NSLayoutConstraint.Relation = .equal) {
        self.init(frame: .zero)
        anchor(dimension: .width, relation: relation, constant: width)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

