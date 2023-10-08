import XCTest
@testable import NSLayoutKid

class BaseTestCase: XCTestCase {
    func test(
        given: () -> Void,
        when: () -> Void,
        then: () -> Void
    ) {
        given()
        when()
        then()
    }
    
    func testExample() {
        // Given
//        let view = UIView()
//        sut.addSubview(view)
        
        // When
//        let constraint = view.anchor(axis: .top, to: sut.safeAreaLayoutGuide)
        
        // Then
//        let result = sut.constraints.contains(where: { $0 == constraint })
//        XCTAssert(true, "Pass")
    }
}
