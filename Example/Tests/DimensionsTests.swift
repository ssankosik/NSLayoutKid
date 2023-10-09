import XCTest
@testable import NSLayoutKid

class DimensionsTests: BaseTestCase {
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
extension DimensionsTests {
    func test_anchor_shouldHandleConstant() {
        // Given
        let size = CGSize(side: 16)
        let view = UIView()
        sut.addSubview(view)

        // When
        let constraint = view.lkd.anchorDimensions(
            to: sut,
            size: size)

        // Then
        let results = NSLK.Dimensions.all.dimensions
            .map({
                constraint[$0]??.constant == size.getSide(dimension: $0)
            })
        let result = results.isAllTrue
        XCTAssert(result)
    }
}

// MARK: - Update
extension DimensionsTests {
    func test_updateAnchor_shouldHandleConstant() {
        // Given
        let size = CGSize(side: 16)
        let view = UIView()
        sut.addSubview(view)
        view.lkd.anchorDimensions(
            to: sut,
            size: size)

        // When
        let constraint = view.lkd.updateAnchorDimensions(
            to: sut,
            toSize: size)

        let results = NSLK.Dimensions.all.dimensions
            .map({
                constraint[$0]??.constant == size.getSide(dimension: $0)
            })
        let result = results.isAllTrue
        XCTAssert(result)
    }
}

// MARK: - Remove
extension DimensionsTests {
    func test_removeAnchor() {
        // Given
        let view = UIView()
        sut.addSubview(view)
        view.lkd.anchorDimensions(to: sut)
        let count = sut.constraints.count

        // When
        view.lkd.removeAnchorDimensions(to: sut)

        // Then
        let countResult = sut.constraints.count
        let result = countResult == count - 2
        XCTAssert(result)
    }
}
