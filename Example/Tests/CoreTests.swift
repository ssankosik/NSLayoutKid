import XCTest
@testable import NSLayoutKid

class CoreTests: BaseTestCase {
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

// MARK: - Core
extension CoreTests {
    func test_getView() {
        // Given
        let view = UIView()
        
        // When
        sut.addSubview(view)
        
        // Then
        let results = [
            sut.getView() == sut,
            sut.safeAreaLayoutGuide.getView() == sut.safeAreaLayoutGuide.owningView,
            view.getView() == view,
            view.safeAreaLayoutGuide.getView() == view.safeAreaLayoutGuide.owningView
        ]
        let result = results.isAllTrue
        XCTAssert(result)
    }
    
    func test_getSuperview() {
        // Given
        let view = UIView()
        
        // When
        sut.addSubview(view)
        
        // Then
        let results = [
            sut.getSuperview() == nil,
            sut.safeAreaLayoutGuide.getSuperview() == nil,
            view.getSuperview() == sut,
            view.safeAreaLayoutGuide.getSuperview() == sut
        ]
        let result = results.isAllTrue
        XCTAssert(result)
    }
}

// MARK: - Axis
extension CoreTests {
    func test_getAxisConstraint() {
        // Given
        let fromAttribute: NSLK.Axis = .top
        let toAttribute: NSLK.Axis = .top
        let view = UIView()
        sut.addSubview(view)
        let constraint = view.anchor(
            attribute: fromAttribute,
            to: sut,
            attribute: toAttribute)

        // When
        var relation: NSLayoutConstraint.Relation?
        var constant: CGFloat?
        var priority: UILayoutPriority?
        var results: [NSLayoutConstraint?] = []
        (0...4).forEach({
            relation = nil
            constant = nil
            priority = nil
            switch $0 {
            case 0:
                break
            case 1:
                relation = .equal
            case 2:
                constant = 0
            case 3:
                priority = .required
            case 4:
                relation = .equal
                constant = 0
                priority = .required
            default:
                XCTFail()
                return
            }
            let result = view.getConstraint(
                axis: fromAttribute,
                relation: relation,
                to: sut,
                axis: toAttribute,
                constant: constant,
                priority: priority)
            results.append(result?.constraint)
        })

        // Then
        let result = results.allSatisfy({ $0 == constraint })
        XCTAssert(result)
    }
    
    func test_getAxisConstraint_givenWrongParameter_shouldError() {
        // Given
        let fromAttribute: NSLK.Axis = .top
        let toAttribute: NSLK.Axis = .top
        let view = UIView()
        sut.addSubview(view)
        view.anchor(
            attribute: fromAttribute,
            to: sut,
            attribute: toAttribute)
        
        // When
        let resultConstraint = view.getConstraint(
            axis: fromAttribute,
            relation: nil,
            to: sut,
            axis: toAttribute,
            constant: nil,
            priority: .defaultHigh
        )?
        .constraint
        
        // Then
        let result = resultConstraint == nil
        XCTAssert(result)
    }
    
    func test_getAxisConstraintReverseExpression() {
        // Given
        let aView = UIView()
        let bView = UIView()
        sut.addSubviews([
            aView,
            bView
        ])
        bView.anchor(
            attribute: NSLK.Axis.left,
            to: aView,
            attribute: NSLK.Axis.right)
        
        // When
        let constraint = aView.getConstraint(
            axis: NSLK.Axis.right,
            relation: nil,
            to: bView,
            axis: NSLK.Axis.left,
            constant: nil,
            priority: nil)
        
        // Then
        let result = constraint.isNotNil
        XCTAssert(result)
    }
    
    func test_getAxisConstraintDifferenceSuperview() {
        // Given
        let aView = UIView()
        let bView = UIView()
        let cView = UIView()
        sut.addSubviews([
            aView,
            bView
        ])
        bView.addSubview(cView)
        cView.anchor(
            attribute: NSLK.Axis.top,
            to: aView,
            attribute: NSLK.Axis.top)
        
        // When
        let constraint = cView.getConstraint(
            axis: NSLK.Axis.top,
            relation: nil,
            to: aView,
            axis: NSLK.Axis.top,
            constant: nil,
            priority: nil)
        
        // Then
        let result = constraint.isNotNil
        XCTAssert(result)
    }
}

// MARK: - Dimension
extension CoreTests {
    func test_getDimensionConstraint() {
        // Given
        let fromAttribute: NSLK.Dimension = .width
        let toAttribute: NSLK.Dimension = .width
        let view = UIView()
        view.addSubview(sut)
        let constraint = view.anchor(
            attribute: fromAttribute,
            to: sut,
            attribute: toAttribute)

        // When
        var relation: NSLayoutConstraint.Relation?
        var multiplier: CGFloat?
        var constant: CGFloat?
        var priority: UILayoutPriority?
        var results: [NSLayoutConstraint?] = []
        (0...5).forEach({
            relation = nil
            multiplier = nil
            constant = nil
            priority = nil
            switch $0 {
            case 0:
                break
            case 1:
                relation = .equal
            case 2:
                multiplier = 1
            case 3:
                constant = 0
            case 4:
                priority = .required
            case 5:
                relation = .equal
                multiplier = 1
                constant = 0
                priority = .required
            default:
                XCTFail()
                return
            }
            let result = view.getConstraint(
                dimension: fromAttribute,
                relation: relation,
                to: sut,
                dimension: toAttribute,
                multiplier: multiplier,
                constant: constant,
                priority: priority)
            results.append(result)
        })

        // Then
        let result = results.allSatisfy({ $0 == constraint })
        XCTAssert(result)
    }
    
    func test_getDimensionConstraint_givenWrongParameter_shouldError() {
        // Given
        let fromAttribute: NSLK.Dimension = .width
        let toAttribute: NSLK.Dimension = .width
        let view = UIView()
        view.addSubview(sut)
        view.anchor(
            attribute: fromAttribute,
            to: sut,
            attribute: toAttribute)
        
        // When
        let resultConstraint = view.getConstraint(
            dimension: fromAttribute,
            relation: nil,
            to: sut,
            dimension: toAttribute,
            multiplier: nil,
            constant: nil,
            priority: .defaultHigh)
        
        // Then
        let result = resultConstraint == nil
        XCTAssert(result)
    }
    
    func test_getDimensionConstraintOnSelf() {
        // Given
        let fromAttribute: NSLK.Dimension = .width
        let toAttribute: NSLK.Dimension = .notAnAttribute
        let constraint = sut.anchor(
            attribute: fromAttribute,
            attribute: toAttribute)
        
        // When
        let resultConstraint = sut.getConstraint(
            dimension: fromAttribute,
            relation: nil,
            to: nil,
            dimension: toAttribute,
            multiplier: nil,
            constant: nil,
            priority: nil)

        // Then
        let result = resultConstraint == constraint
        XCTAssert(result)
    }
    
    func test_getDimensionConstraintReverseExpression() {
        // Given
        let aView = UIView()
        sut.addSubview(aView)
        aView.anchor(
            attribute: NSLK.Dimension.height,
            to: sut,
            attribute: NSLK.Dimension.width)
        
        // When
        let constraint = sut.getConstraint(
            dimension: NSLK.Dimension.width,
            relation: nil,
            to: aView,
            dimension: NSLK.Dimension.height,
            multiplier: nil,
            constant: nil,
            priority: nil)
        
        // Then
        let result = constraint.isNotNil
        XCTAssert(result)
    }
    
    func test_getDimensionConstraintDifferenceSuperview() {
        // Given
        let aView = UIView()
        let bView = UIView()
        let cView = UIView()
        sut.addSubviews([
            aView,
            bView
        ])
        bView.addSubview(cView)
        cView.anchor(
            attribute: NSLK.Dimension.height,
            to: aView,
            attribute: NSLK.Dimension.height)
        
        // When
        let constraint = cView.getConstraint(
            dimension: NSLK.Dimension.height,
            relation: nil,
            to: aView,
            dimension: NSLK.Dimension.height,
            multiplier: nil,
            constant: nil,
            priority: nil)
        
        // Then
        let result = constraint.isNotNil
        XCTAssert(result)
    }
}
