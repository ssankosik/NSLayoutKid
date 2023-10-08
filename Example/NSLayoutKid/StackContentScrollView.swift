import UIKit

class StackContentScrollView: UIScrollView {
    let contentView: UIView = .init()
    let stackView = UIStackView(axis: .vertical)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        delaysContentTouches = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceVertical = true
        alwaysBounceHorizontal = false
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        } else {
            contentInset = .zero
        }
        addSubview(contentView)
        contentView.addSubview(stackView)
        contentView.nslk.anchorToSuperView()
        contentView.nslk.anchorToSuperView(dimension: .width, priority: .required)
        contentView.nslk.anchorToSuperView(dimension: .height, priority: .fittingSizeLevel)
        stackView.nslk.anchorToSuperView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func set(masksToBounds: Bool) {
        layer.masksToBounds = false
        contentView.layer.masksToBounds = false
        stackView.layer.masksToBounds = false
    }
    
    func set(axis: NSLayoutConstraint.Axis) {
        stackView.axis = axis
        contentView.nslk.updateAnchorToSuperView(dimension: .width, priority: axis == .vertical ? .required : .fittingSizeLevel)
        contentView.nslk.updateAnchorToSuperView(dimension: .height, priority: axis == .vertical ? .fittingSizeLevel : .required)
    }
}
