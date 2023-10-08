import Foundation

extension Array where Element == Bool {
    var isAllTrue: Bool {
        allSatisfy({ $0 == true })
    }
    
    var isAllFalse: Bool {
        !isAllTrue
    }
}
