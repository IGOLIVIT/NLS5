import Foundation

struct StarPoint: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let x: Double
    let y: Double
    let size: Double
    let isFragmentStar: Bool

    static func == (lhs: StarPoint, rhs: StarPoint) -> Bool {
        lhs.id == rhs.id
    }
}
