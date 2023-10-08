import UIKit

class CardView: UIView {
    let contentView = UIView().apply({
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubview(contentView)
        contentView.nslk.anchorToSuperView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(radius: 16)
        updateShadowPath()
    }
    
    func setupView() {
        roundCorners(radius: 16)
        addShadow(cornerRadius: 16)
    }
}
