import Foundation
import Combine

enum GameState {
    case ready
    case playing
    case wrongTapWarning
    case completed
    case paused
}

final class ConstellationGameEngine: ObservableObject {

    @Published var level: ConstellationLevel
    @Published var currentRoute: [Int] = []
    @Published var mistakes: Int = 0
    @Published var hintsUsed: Int = 0
    @Published var gameState: GameState = .ready
    @Published var hintStarId: Int? = nil
    @Published var wrongTapStarId: Int? = nil
    @Published var fragmentCollected: Bool = false

    private var hintTimer: AnyCancellable?
    private var warningTimer: AnyCancellable?

    init(level: ConstellationLevel) {
        self.level = level
    }

    // MARK: - Game Actions

    func tapStar(_ starId: Int) {
        guard gameState == .playing || gameState == .ready else { return }
        gameState = .playing

        let expectedIndex = currentRoute.count
        guard expectedIndex < level.correctRoute.count else { return }
        let expectedId = level.correctRoute[expectedIndex]

        if starId == expectedId {
            currentRoute.append(starId)
            if let star = level.stars.first(where: { $0.id == starId }), star.isFragmentStar {
                fragmentCollected = true
            }
            if currentRoute.count == level.correctRoute.count {
                gameState = .completed
            }
        } else {
            mistakes += 1
            wrongTapStarId = starId
            gameState = .wrongTapWarning
            warningTimer?.cancel()
            warningTimer = Just(())
                .delay(for: .seconds(1.2), scheduler: RunLoop.main)
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    if self.gameState == .wrongTapWarning {
                        self.gameState = .playing
                        self.wrongTapStarId = nil
                    }
                }
        }
    }

    func undo() {
        guard !currentRoute.isEmpty, gameState != .completed else { return }
        currentRoute.removeLast()
        gameState = .playing
        wrongTapStarId = nil
    }

    func restart() {
        currentRoute = []
        mistakes = 0
        hintsUsed = 0
        fragmentCollected = false
        hintStarId = nil
        wrongTapStarId = nil
        hintTimer?.cancel()
        warningTimer?.cancel()
        gameState = .ready
    }

    func useHint() {
        guard gameState == .playing || gameState == .ready || gameState == .wrongTapWarning else { return }
        guard currentRoute.count < level.correctRoute.count else { return }
        hintsUsed += 1
        let nextIndex = currentRoute.count
        if nextIndex < level.correctRoute.count {
            hintStarId = level.correctRoute[nextIndex]
        }
        hintTimer?.cancel()
        hintTimer = Just(())
            .delay(for: .seconds(1.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.hintStarId = nil
            }
    }

    func pause() {
        guard gameState == .playing || gameState == .ready else { return }
        gameState = .paused
    }

    func resume() {
        guard gameState == .paused else { return }
        gameState = currentRoute.isEmpty ? .ready : .playing
    }

    // MARK: - Computed

    var completedConnections: [StarConnection] {
        guard currentRoute.count >= 2 else { return [] }
        var result: [StarConnection] = []
        for i in 0..<(currentRoute.count - 1) {
            result.append(StarConnection(from: currentRoute[i], to: currentRoute[i + 1]))
        }
        return result
    }

    var currentActiveStar: Int? {
        currentRoute.last
    }

    var nextExpectedStar: Int? {
        let nextIndex = currentRoute.count
        if nextIndex < level.correctRoute.count {
            return level.correctRoute[nextIndex]
        }
        return nil
    }

    var progressFraction: Double {
        guard level.correctRoute.count > 1 else { return 0 }
        return Double(currentRoute.count) / Double(level.correctRoute.count)
    }

    func calculateSkyMarks() -> Int {
        if mistakes == 0 && hintsUsed == 0 { return 3 }
        if mistakes <= 2 || hintsUsed <= 1 { return 2 }
        return 1
    }

    func isPerfectRoute() -> Bool {
        mistakes == 0 && hintsUsed == 0
    }
}
