import UIKit
import NSLayoutKid

class ViewController: UIViewController {
    // UI
    private let centerView = UIView().apply({
        $0.backgroundColor = .gray
        $0.anchorDimensions(size: .init(side: 100))
    })
    
    // VAR
    private var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        func createHeaderView() -> UIView {
            let imageView = UIImageView().apply({
                $0.backgroundColor = .grey03
                $0.roundCorners(radius: 50)
                $0.anchorDimensions(size: .init(side: 100))
            })
            let titleLabel = UILabel().apply({
                $0.text = "Title"
            })
            let descriptionLabel = UILabel().apply({
                $0.text = "Description"
            })
            return UIStackView(axis: .vertical).apply({
                $0.alignment = .center
                $0.addArrangedSubviews([
                    imageView,
                    Spacer(height: 24),
                    titleLabel,
                    Spacer(height: 8),
                    descriptionLabel
                ])
            })
        }
        
        func createDetailsView() -> UIView {
            CardView().apply({
                $0.addSubview(centerView)
                $0.anchor(dimension: .height, constant: 500)
                centerView.anchorToSuperView(axes: .center)
            })
        }
        
        let scrollView = StackContentScrollView().apply({
            $0.set(masksToBounds: false)
            $0.stackView.updateAnchorToSuperView(insets: .init(inset: 16, top: 32, bottom: 40))
        })
        view.backgroundColor = .grey02
        view.addSubview(scrollView)
        scrollView.stackView.addArrangedSubviews([
            createHeaderView(),
            Spacer(height: 32),
            createDetailsView()
        ])
        scrollView.anchor(axis: .top, to: view.safeAreaLayoutGuide)
        scrollView.anchorToSuperView(axes: .bottom)
        navigationItem.title = "ViewController"
        
        let tap = UITapGestureRecognizer().apply({
            $0.addTarget(self, action: #selector(tapped))
        })
        view.addGestureRecognizer(tap)
    }
    
    @objc private func tapped() {
        counter += 1
        centerView.updateAnchorDimensions(size: .init(side: counter.isEven ? 100 : 50))
    }
}
