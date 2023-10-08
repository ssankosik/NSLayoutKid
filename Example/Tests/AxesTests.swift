import XCTest
@testable import NSLayoutKid

class AxesTests: BaseTestCase {
    var sut: UIView!
    
    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Anchor
extension AxesTests {
    func test_anchor_shouldHandleRelationAndConstant() {
        // Given
        let relation = NSLayoutConstraint.Relation.greaterThanOrEqual
        let constant = CGFloat(16)
        let view = UIView()
        sut.addSubview(view)
        
        // When
        let constraint = view.nslk.anchor(
            relation: relation,
            to: sut,
            insets: .init(inset: constant))
        
        // Then
        let results = NSLK.Axes.all.axes
            .map({
                let constraint = constraint[$0]
                return [
                    constraint??.relation == relation.getTranslated(axis: $0),
                    constraint??.constant == constant.getTranslated(axis: $0)
                ]
            })
            .flatMap({ $0 })
        let result = results.isAllTrue
        XCTAssert(result)
    }
}

// MARK: - Update
extension AxesTests {
    func test_updateAnchor_shouldHandleConstant() {
        // Given
        let constant = CGFloat(16)
        let view = UIView()
        sut.addSubview(view)
        view.nslk.anchor(
            to: sut,
            insets: .init(inset: constant))
        
        // When
        let constraint = view.nslk.updateAnchor(
            to: sut,
            toInsets: .init(inset: constant))
        
        let results = NSLK.Axes.all.axes
            .map({
                constraint[$0]??.constant == constant.getTranslated(axis: $0)
            })
        let result = results.isAllTrue
        XCTAssert(result)
    }
}

// MARK: - Remove
extension AxesTests {
    func test_removeAnchor() {
        // Given
        let view = UIView()
        sut.addSubview(view)
        view.nslk.anchor(to: sut)
        let count = sut.constraints.count
        
        // When
        view.nslk.removeAnchor(to: sut)
        
        // Then
        let countResult = sut.constraints.count
        let result = countResult == count - 4
        XCTAssert(result)
    }
}
