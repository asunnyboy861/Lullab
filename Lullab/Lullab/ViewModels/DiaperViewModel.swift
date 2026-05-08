import Foundation
import SwiftUI
import Combine

@MainActor
final class DiaperViewModel: ObservableObject {
    @Published var diaperType: DiaperType = .wet
    @Published var color: DiaperColor = .yellow
    @Published var notes: String = ""
    @Published var saved: Bool = false

    private let persistence = PersistenceController.shared

    func save() {
        let metadata = DiaperMetadata(
            diaperType: diaperType,
            color: color,
            notes: notes.isEmpty ? nil : notes
        )
        persistence.createEvent(type: .diaper, metadata: metadata, notes: notes.isEmpty ? nil : notes)
        saved = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
