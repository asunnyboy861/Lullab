import SwiftUI

struct SleepDetailView: View {
    @StateObject private var vm = SleepViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if vm.isTimerRunning {
                        timerView
                    } else {
                        startButton
                    }

                    qualityPicker
                    notesField

                    if !vm.isTimerRunning {
                        LullabButton("Save Sleep", icon: "moon.fill", color: .lullabSleep) {
                            vm.saveCompletedSleep()
                        }
                    }
                }
                .padding()
            }
            .background(Color.lullabBackground)
            .navigationTitle("Sleep")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(.lullabAccent)
                }
            }
            .alert("Saved!", isPresented: $vm.saved) { Button("OK") { dismiss() } }
        }
    }

    private var timerView: some View {
        VStack(spacing: 12) {
            Text(timeString)
                .font(.lullabTimer)
                .foregroundStyle(.lullabSleep)
                .monospacedDigit()

            LullabButton("Stop Timer", icon: "stop.fill", color: .lullabSleep) {
                vm.stopTimer()
            }
        }
        .padding()
        .background(Color.lullabSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var timeString: String {
        let elapsed = Date().timeIntervalSince(vm.timerStart)
        let hours = Int(elapsed) / 3600
        let minutes = Int(elapsed) % 3600 / 60
        let seconds = Int(elapsed) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private var startButton: some View {
        LullabButton("Start Sleep Timer", icon: "moon.fill", color: .lullabSleep) {
            vm.startTimer()
        }
    }

    private var qualityPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quality")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)

            HStack(spacing: 12) {
                ForEach(SleepQuality.allCases, id: \.self) { q in
                    Button {
                        vm.quality = q
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: q.icon)
                                .font(.title3)
                            Text(q.displayName)
                                .font(.lullabCaption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(vm.quality == q ? Color.lullabSleep.opacity(0.3) : Color.lullabSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            if vm.quality == q {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.lullabSleep, lineWidth: 2)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(vm.quality == q ? .lullabSleep : .lullabTextSecondary)
                }
            }
        }
    }

    private var notesField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notes")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("Optional notes...", text: $vm.notes)
                .padding(12)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
        }
    }
}
