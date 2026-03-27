import Foundation

enum ModelStatus: Equatable {
    case idle
    case loading
    case ready
    case generating
    case failed(String)
}
