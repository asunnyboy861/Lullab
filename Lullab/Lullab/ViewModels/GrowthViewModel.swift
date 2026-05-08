import Foundation
import SwiftUI
import Combine

@MainActor
final class GrowthViewModel: ObservableObject {
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var headCircumference: String = ""
    @Published var notes: String = ""
    @Published var saved: Bool = false

    private let persistence = PersistenceController.shared

    func save() {
        let metadata = GrowthMetadata(
            weight: Double(weight),
            height: Double(height),
            headCircumference: Double(headCircumference),
            notes: notes.isEmpty ? nil : notes
        )
        persistence.createEvent(type: .growth, metadata: metadata, notes: notes.isEmpty ? nil : notes)
        saved = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
