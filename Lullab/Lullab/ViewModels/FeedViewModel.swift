import Foundation
import SwiftUI
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var feedType: FeedType = .bottle
    @Published var breastSide: BreastSide = .left
    @Published var volume: String = ""
    @Published var duration: String = ""
    @Published var notes: String = ""
    @Published var saved: Bool = false

    private let persistence = PersistenceController.shared

    func save() {
        let vol = Double(volume)
        let dur = TimeInterval(duration) ?? 0
        let metadata = FeedMetadata(
            feedType: feedType,
            breastSide: feedType == .breast ? breastSide : nil,
            duration: feedType == .breast ? dur : nil,
            volume: feedType == .bottle ? vol : nil,
            unit: "ml",
            notes: notes.isEmpty ? nil : notes
        )
        persistence.createEvent(type: .feed, metadata: metadata, notes: notes.isEmpty ? nil : notes)
        saved = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
