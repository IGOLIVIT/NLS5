import Foundation

struct StarConnection: Identifiable, Equatable {
    let id: String
    let fromStarId: Int
    let toStarId: Int

    init(from: Int, to: Int) {
        self.fromStarId = from
        self.toStarId = to
        self.id = "\(from)-\(to)"
    }
}
