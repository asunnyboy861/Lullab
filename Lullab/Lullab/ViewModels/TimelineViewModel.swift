import Foundation
import Combine

@MainActor
final class TimelineViewModel: ObservableObject {
    @Published var events: [CDEvent] = []
    @Published var filter: EventType? = nil

    private let persistence = PersistenceController.shared

    func loadEvents() {
        if let filter {
            let all = persistence.fetchAllEvents(limit: 200)
            events = all.filter { $0.type == filter.rawValue }
        } else {
            events = persistence.fetchAllEvents(limit: 200)
        }
    }

    func deleteEvent(_ event: CDEvent) {
        persistence.deleteEvent(event)
        loadEvents()
    }

    func setFilter(_ type: EventType?) {
        filter = type
        loadEvents()
    }
}
