import Foundation
import CoreData
import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var babyName: String = "Baby"
    @Published var babyAge: String = ""
    @Published var lastFeedTime: String = "—"
    @Published var lastSleepTime: String = "—"
    @Published var lastDiaperTime: String = "—"
    @Published var lastGrowthTime: String = "—"
    @Published var todayEvents: [CDEvent] = []
    @Published var isSleepTimerRunning: Bool = false

    private let persistence = PersistenceController.shared

    func loadBaby() {
        if let baby = persistence.fetchBaby() {
            babyName = baby.name ?? "Baby"
            babyAge = (baby.birthdate ?? Date()).ageString
        }
    }

    func loadTodayEvents() {
        todayEvents = persistence.fetchEvents(for: Date())
        updateLastTimes()
    }

    private func updateLastTimes() {
        let events = todayEvents
        lastFeedTime = events.filter { $0.type == "feed" }.first?.timestamp?.shortTimeString ?? "—"
        lastSleepTime = events.filter { $0.type == "sleep" }.first?.timestamp?.shortTimeString ?? "—"
        lastDiaperTime = events.filter { $0.type == "diaper" }.first?.timestamp?.shortTimeString ?? "—"
        lastGrowthTime = events.filter { $0.type == "growth" }.first?.timestamp?.shortTimeString ?? "—"
    }

    func logFeed() {
        let metadata = FeedMetadata(feedType: .bottle, unit: "ml")
        persistence.createEvent(type: .feed, metadata: metadata)
        loadTodayEvents()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func logSleep() {
        persistence.createEvent(type: .sleep)
        if #available(iOS 17.0, *) {
            LiveActivityManager.shared.startSleepTimer(babyName: babyName)
        }
        isSleepTimerRunning = true
        loadTodayEvents()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func logDiaper() {
        let metadata = DiaperMetadata(diaperType: .wet)
        persistence.createEvent(type: .diaper, metadata: metadata)
        loadTodayEvents()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func logGrowth() {
        persistence.createEvent(type: .growth)
        loadTodayEvents()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
