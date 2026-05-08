import SwiftUI

extension Date {
    var timeAgoString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }

    var shortTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    var fullDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var ageString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: self, to: Date())
        if let months = components.month, months > 0 {
            return "\(months)m \(components.day ?? 0)d"
        }
        return "\(components.day ?? 0)d"
    }
}

extension View {
    func lullabBackground() -> some View {
        self.background(Color.lullabBackground)
    }

    func lullabNavigation() -> some View {
        self.navigationBarTitleDisplayMode(.inline)
            .tint(.lullabAccent)
    }
}
