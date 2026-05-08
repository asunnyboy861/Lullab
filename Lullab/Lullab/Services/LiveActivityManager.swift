import Foundation
import ActivityKit
import Combine

@available(iOS 17.0, *)
struct SleepActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var startTime: Date
        var babyName: String
    }
    var babyName: String
}

@MainActor
final class LiveActivityManager: ObservableObject {
    static let shared = LiveActivityManager()
    private var currentActivity: Activity<SleepActivityAttributes>?

    func startSleepTimer(babyName: String) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }

        let attributes = SleepActivityAttributes(babyName: babyName)
        let state = SleepActivityAttributes.ContentState(
            startTime: Date(),
            babyName: babyName
        )

        do {
            currentActivity = try Activity.request(
                attributes: attributes,
                content: .init(state: state, staleDate: nil),
                pushType: nil
            )
        } catch {
            print("Live Activity failed: \(error)")
        }
    }

    func stopSleepTimer() {
        Task {
            await currentActivity?.end(
                .init(state: .init(startTime: Date(), babyName: ""), staleDate: nil),
                dismissalPolicy: .immediate
            )
            currentActivity = nil
        }
    }

    func isTimerRunning() -> Bool {
        currentActivity != nil
    }
}
