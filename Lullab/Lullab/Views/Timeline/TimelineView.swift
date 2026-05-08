import SwiftUI

struct TimelineView: View {
    @StateObject private var vm = TimelineViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterBar

                if vm.events.isEmpty {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.largeTitle)
                            .foregroundStyle(.lullabTextSecondary)
                        Text("No events yet")
                            .font(.lullabBody)
                            .foregroundStyle(.lullabTextSecondary)
                    }
                    Spacer()
                } else {
                    List {
                        ForEach(vm.events) { event in
                            TimelineEventRow(event: event)
                                .listRowBackground(Color.lullabBackground)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        vm.deleteEvent(event)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .background(Color.lullabBackground)
            .navigationTitle("Timeline")
            .onAppear { vm.loadEvents() }
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterChip(label: "All", isSelected: vm.filter == nil) {
                    vm.setFilter(nil)
                }
                ForEach(EventType.allCases, id: \.self) { type in
                    FilterChip(label: type.displayName, isSelected: vm.filter == type) {
                        vm.setFilter(type)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

struct FilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.lullabCaption.bold())
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? Color.lullabAccent : Color.lullabSurface)
                .foregroundStyle(isSelected ? .black : .lullabTextSecondary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

struct TimelineEventRow: View {
    let event: CDEvent

    private var eventType: EventType? {
        EventType(rawValue: event.type ?? "")
    }

    private var color: Color {
        switch eventType {
        case .feed: .lullabFeed
        case .sleep: .lullabSleep
        case .diaper: .lullabDiaper
        case .growth: .lullabGrowth
        default: .lullabTextSecondary
        }
    }

    private var detailText: String {
        guard let data = event.metadata else { return "" }
        switch eventType {
        case .feed:
            if let meta = try? JSONDecoder().decode(FeedMetadata.self, from: data) {
                var parts = [meta.feedType.displayName]
                if let v = meta.volume { parts.append("\(Int(v))\(meta.unit)") }
                if let d = meta.duration { parts.append("\(Int(d/60))min") }
                return parts.joined(separator: " · ")
            }
        case .sleep:
            if let meta = try? JSONDecoder().decode(SleepMetadata.self, from: data) {
                var parts = [String]()
                if let d = meta.duration { parts.append("\(Int(d/60))min") }
                if let q = meta.quality { parts.append(q.displayName) }
                return parts.joined(separator: " · ")
            }
        case .diaper:
            if let meta = try? JSONDecoder().decode(DiaperMetadata.self, from: data) {
                var parts = [meta.diaperType.displayName]
                if let c = meta.color { parts.append(c.displayName) }
                return parts.joined(separator: " · ")
            }
        case .growth:
            if let meta = try? JSONDecoder().decode(GrowthMetadata.self, from: data) {
                var parts = [String]()
                if let w = meta.weight { parts.append("\(w)\(meta.weightUnit)") }
                if let h = meta.height { parts.append("\(h)\(meta.heightUnit)") }
                return parts.joined(separator: " · ")
            }
        default: break
        }
        return ""
    }

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: eventType?.icon ?? "circle")
                        .foregroundStyle(color)
                        .font(.body)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text(eventType?.displayName ?? "Event")
                    .font(.lullabBody.bold())
                    .foregroundStyle(.lullabTextPrimary)
                if !detailText.isEmpty {
                    Text(detailText)
                        .font(.lullabCaption)
                        .foregroundStyle(.lullabTextSecondary)
                }
            }

            Spacer()

            Text(event.timestamp?.shortTimeString ?? "")
                .font(.lullabCaption)
                .foregroundStyle(.lullabTextSecondary)
        }
        .padding(.vertical, 4)
    }
}
