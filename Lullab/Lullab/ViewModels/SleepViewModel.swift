import Foundation
import SwiftUI
import Combine

@MainActor
final class SleepViewModel: ObservableObject {
    @Published var quality: SleepQuality = .normal
    @Published var notes: String = ""
    @Published var saved: Bool = false
    @Published var isTimerRunning: Bool = false
    @Published var timerStart: Date = Date()

    private let persistence = PersistenceController.shared

    func startTimer() {
        timerStart = Date()
        isTimerRunning = true
        persistence.createEvent(type: .sleep)
        if #available(iOS 17.0, *) {
            let babyName = persistence.fetchBaby()?.name ?? "Baby"
            LiveActivityManager.shared.startSleepTimer(babyName: babyName)
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func stopTimer() {
        isTimerRunning = false
        if #available(iOS 17.0, *) {
            LiveActivityManager.shared.stopSleepTimer()
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func saveCompletedSleep() {
        let duration = isTimerRunning ? Date().timeIntervalSince(timerStart) : nil
        let metadata = SleepMetadata(
            duration: duration,
            quality: quality,
            notes: notes.isEmpty ? nil : notes
        )
        persistence.createEvent(type: .sleep, metadata: metadata, notes: notes.isEmpty ? nil : notes)
        saved = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
