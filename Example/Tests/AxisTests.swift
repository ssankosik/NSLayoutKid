import XCTest
@testable import NSLayoutKid

class AxisTests: BaseTestCase {
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
extension AxisTests {
    func test_anchor_shouldHandleRelationAndConstantAndSecondAttribute(
        axis: NSLK.Axis,
        relation: NSLayoutConstraint.Relation,
        constant: CGFloat,
        expectedRelation: NSLayoutConstraint.Relation,
        expectedConstant: CGFloat
    ) {
        // Given
        let view = UIView()
        sut.addSubview(view)
        
        // When
        let constraint = view.lkd.anchor(
            axis: axis,
            relation: relation,
            to: sut,
            constant: constant)
        
        // Then
        let results = [
            constraint?.relation == expectedRelation,
            constraint?.secondAttribute == axis.attribute,
            constraint?.constant == expectedConstant
        ]
        let result = results.isAllTrue
        XCTAssert(result)
    }
    
    func test_anchor_shouldHandleRelationAndConstantAndSecondAttribute() {
        let relation = NSLayoutConstraint.Relation.greaterThanOrEqual
        let constant = CGFloat(16)
        NSLK.Axes.all.axes.forEach({
            test_anchor_shouldHandleRelationAndConstantAndSecondAttribute(
                axis: $0,
                relation: relation,
                constant: constant,
                expectedRelation: relation.getTranslated(axis: $0),
                expectedConstant: constant.getTranslated(axis: $0))
        })
    }
}

// MARK: - Update
extension AxisTests {
    func test_updateAnchor_shouldHandleConstantAndSecondAttribute(
        axis: NSLK.Axis,
        constant: CGFloat,
        expectedConstant: CGFloat
    ) {
        // Given
        let view = UIView()
        sut.addSubview(view)
        view.lkd.anchor(
            axis: axis,
            to: sut,
            constant: constant)
        
        // When
        let constraint = view.lkd.updateAnchor(
            axis: axis,
            to: sut,
            toConstant: constant)
        
        // Then
        let results = [
            constraint?.secondAttribute == axis.attribute,
            constraint?.constant == expectedConstant
        ]
        let result = results.isAllTrue
        XCTAssert(result)
    }
    
    func test_updateAnchor_shouldHandleRelationAndConstantAndSecondAttribute() {
        let constant = CGFloat(16)
        NSLK.Axes.all.axes.forEach({
            test_updateAnchor_shouldHandleConstantAndSecondAttribute(
                axis: $0,
                constant: constant,
                expectedConstant: constant.getTranslated(axis: $0))
        })
    }
}


// MARK: - Remove
extension AxisTests {
    func test_removeAnchor() {
        // Given
        let axis = NSLK.Axis.top
        let view = UIView()
        sut.addSubview(view)
        view.lkd.anchor(
            axis: axis,
            to: sut)
        let count = sut.constraints.count
        
        // When
        let constraint = view.lkd.removeAnchor(
            axis: axis,
            to: sut)
        
        // Then
        let countResult = sut.constraints.count
        let results = [
            countResult == count - 1,
            constraint?.secondAttribute == axis.attribute
        ]
        let result = results.isAllTrue
        XCTAssert(result)
    }
}
