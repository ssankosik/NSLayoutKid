import Foundation

protocol Apply {}
extension Apply where Self: Any {
  @discardableResult
  func apply(_ block: ((Self) throws -> Void)) rethrows -> Self {
    try block(self)
    return self
  }
}

extension NSObject: Apply {}

extension Array: Apply {}
extension Dictionary: Apply {}
extension Set: Apply {}
