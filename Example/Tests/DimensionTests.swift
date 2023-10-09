import XCTest
@testable import NSLayoutKid

class DimensionTests: BaseTestCase {
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
extension DimensionTests {
    func test_anchor_shouldReturnNotAnAttribute() {
        // When
        let dimension = NSLK.Dimension.width
        let constraint = sut.lkd.anchor(dimension: dimension)

        // Then
        let result = constraint?.secondAttribute == .notAnAttribute
        XCTAssert(result)
    }
    
    func test_anchor_givenToItem_shouldHandleSecondAttribute() {
        // Given
        let dimension = NSLK.Dimension.width
        let view = UIView()
        sut.addSubview(view)

        // When
        let constraint = view.lkd.anchor(
            dimension: dimension,
            to: sut)

        // Then
        let result = constraint?.secondAttribute == .width
        XCTAssert(result)
    }
}

// MARK: - Update
extension DimensionTests {
    func test_updateAnchor_shouldReturnNotAnAttribute() {
        // Given
        let dimension = NSLK.Dimension.width
        sut.lkd.anchor(
            dimension: dimension,
            constant: 16)
        
        // When
        let constraint = sut.lkd.updateAnchor(
            dimension: dimension,
            toConstant: 16)

        // Then
        let result = constraint?.secondAttribute == .notAnAttribute
        XCTAssert(result)
    }
    
    func test_updateAnchor_givenToItem_shouldHandleSecondAttribute() {
        // Given
        let dimension = NSLK.Dimension.width
        let view = UIView()
        sut.addSubview(view)
        view.lkd.anchor(
            dimension: dimension,
            to: sut,
            constant: 16)

        // When
        let constraint = view.lkd.updateAnchor(
            dimension: dimension,
            to: sut,
            toConstant: 16)

        // Then
        let result = constraint?.secondAttribute == dimension.attribute
        XCTAssert(result)
    }
}

// MARK: - Remove
extension DimensionTests {
    func test_removeAnchor() {
        // Given
        let dimension = NSLK.Dimension.width
        sut.lkd.anchor(
            dimension: dimension,
            constant: 16)
        
        // When
        let constraint = sut.lkd.removeAnchor(
            dimension: dimension,
            constant: 16)

        // Then
        let result = constraint?.secondAttribute == .notAnAttribute
        XCTAssert(result)
    }
    
    func test_removeAnchor_givenToItem_shouldHandleSecondAttribute() {
        // Given
        let dimension = NSLK.Dimension.width
        let view = UIView()
        sut.addSubview(view)
        view.lkd.anchor(
            dimension: dimension,
            to: sut)
        let count = sut.constraints.count
        
        // When
        let constraint = view.lkd.removeAnchor(
            dimension: dimension,
            to: sut)

        // Then
        let countResult = sut.constraints.count
        let results = [
            countResult == count - 1,
            constraint?.secondAttribute == dimension.attribute
        ]
        let result = results.isAllTrue
        XCTAssert(result)
    }
}
