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
        contentView.lkd.anchorToSuperView()
        contentView.lkd.anchorToSuperView(dimension: .width, priority: .required)
        contentView.lkd.anchorToSuperView(dimension: .height, priority: .fittingSizeLevel)
        stackView.lkd.anchorToSuperView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func set(masksToBounds: Bool) {
        layer.masksToBounds = false
        contentView.layer.masksToBounds = false
        stackView.layer.masksToBounds = false
    }
    
    func set(axis: NSLayoutConstraint.Axis) {
        stackView.axis = axis
        contentView.lkd.updateAnchorToSuperView(dimension: .width, priority: axis == .vertical ? .required : .fittingSizeLevel)
        contentView.lkd.updateAnchorToSuperView(dimension: .height, priority: axis == .vertical ? .fittingSizeLevel : .required)
    }
}
