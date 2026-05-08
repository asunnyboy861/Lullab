import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var showFeedDetail = false
    @State private var showSleepDetail = false
    @State private var showDiaperDetail = false
    @State private var showGrowthDetail = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    BabyHeaderView(name: vm.babyName, age: vm.babyAge)

                    LastEventBar(
                        lastFeed: vm.lastFeedTime,
                        lastSleep: vm.lastSleepTime,
                        lastDiaper: vm.lastDiaperTime,
                        lastGrowth: vm.lastGrowthTime
                    )

                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ], spacing: 12) {
                        QuickLogTile(
                            title: "Feed",
                            icon: "drop.fill",
                            color: .lullabFeed,
                            lastTime: vm.lastFeedTime
                        ) {
                            vm.logFeed()
                            showFeedDetail = true
                        }

                        QuickLogTile(
                            title: "Sleep",
                            icon: "moon.fill",
                            color: .lullabSleep,
                            lastTime: vm.lastSleepTime
                        ) {
                            vm.logSleep()
                            showSleepDetail = true
                        }

                        QuickLogTile(
                            title: "Diaper",
                            icon: "circle.fill",
                            color: .lullabDiaper,
                            lastTime: vm.lastDiaperTime
                        ) {
                            vm.logDiaper()
                            showDiaperDetail = true
                        }

                        QuickLogTile(
                            title: "Growth",
                            icon: "chart.line.uptrend.xyaxis",
                            color: .lullabGrowth,
                            lastTime: vm.lastGrowthTime
                        ) {
                            vm.logGrowth()
                            showGrowthDetail = true
                        }
                    }
                    .padding(.horizontal)

                    TodayTimelineView(events: vm.todayEvents)
                }
                .padding(.top, 8)
            }
            .background(Color.lullabBackground)
            .navigationTitle("")
            .sheet(isPresented: $showFeedDetail) { FeedDetailView() }
            .sheet(isPresented: $showSleepDetail) { SleepDetailView() }
            .sheet(isPresented: $showDiaperDetail) { DiaperDetailView() }
            .sheet(isPresented: $showGrowthDetail) { GrowthDetailView() }
            .onAppear {
                vm.loadBaby()
                vm.loadTodayEvents()
            }
        }
    }
}

struct QuickLogTile: View {
    let title: String
    let icon: String
    let color: Color
    let lastTime: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)

                Text(title)
                    .font(.lullabTitle3)
                    .foregroundStyle(.lullabTextPrimary)

                Text(lastTime)
                    .font(.lullabCaption)
                    .foregroundStyle(.lullabTextSecondary)
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(Color.lullabSurface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

struct BabyHeaderView: View {
    let name: String
    let age: String

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.lullabAccent.opacity(0.2))
                .frame(width: 48, height: 48)
                .overlay {
                    Image(systemName: "moon.stars.fill")
                        .foregroundStyle(.lullabAccent)
                        .font(.title3)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.lullabTitle2)
                    .foregroundStyle(.lullabTextPrimary)
                Text(age)
                    .font(.lullabCaption)
                    .foregroundStyle(.lullabTextSecondary)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}

struct LastEventBar: View {
    let lastFeed: String
    let lastSleep: String
    let lastDiaper: String
    let lastGrowth: String

    var body: some View {
        HStack(spacing: 16) {
            LastEventChip(icon: "drop.fill", color: .lullabFeed, time: lastFeed)
            LastEventChip(icon: "moon.fill", color: .lullabSleep, time: lastSleep)
            LastEventChip(icon: "circle.fill", color: .lullabDiaper, time: lastDiaper)
            LastEventChip(icon: "chart.line.uptrend.xyaxis", color: .lullabGrowth, time: lastGrowth)
        }
        .padding(.horizontal)
    }
}

struct LastEventChip: View {
    let icon: String
    let color: Color
    let time: String

    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(color)
            Text(time)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(.lullabTextSecondary)
        }
    }
}

struct TodayTimelineView: View {
    let events: [CDEvent]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LullabSectionHeader("Today", icon: "clock.fill", color: .lullabAccent)

            if events.isEmpty {
                Text("No events yet. Tap a tile above to start tracking!")
                    .font(.lullabBody)
                    .foregroundStyle(.lullabTextSecondary)
                    .padding()
            } else {
                ForEach(events.prefix(10)) { event in
                    TimelineEventRow(event: event)
                }
            }
        }
        .padding(.horizontal)
    }
}
