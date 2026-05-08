import SwiftUI

struct OnboardingView: View {
    @State private var showBabySetup = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "moon.stars.fill")
                .font(.system(size: 72))
                .foregroundStyle(.lullabAccent)

            Text("Lullab")
                .font(.lullabLargeTitle)
                .foregroundStyle(.lullabTextPrimary)

            Text("The calmest, simplest newborn tracker.\n1-tap logging for 3 AM nights.")
                .font(.lullabBody)
                .foregroundStyle(.lullabTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            VStack(alignment: .leading, spacing: 16) {
                OnboardingFeatureRow(icon: "drop.fill", color: .lullabFeed, text: "Track feeds in 1 tap")
                OnboardingFeatureRow(icon: "moon.fill", color: .lullabSleep, text: "Sleep timer with Live Activity")
                OnboardingFeatureRow(icon: "circle.fill", color: .lullabDiaper, text: "Diaper changes made simple")
                OnboardingFeatureRow(icon: "chart.line.uptrend.xyaxis", color: .lullabGrowth, text: "Growth tracking with charts")
            }
            .padding(.horizontal, 32)

            Spacer()

            LullabButton("Get Started", icon: "arrow.right", color: .lullabAccent) {
                showBabySetup = true
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .background(Color.lullabBackground)
        .sheet(isPresented: $showBabySetup) {
            BabySetupView(isOnboarding: true) {
                hasCompletedOnboarding = true
            }
        }
    }
}

struct OnboardingFeatureRow: View {
    let icon: String
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
                .frame(width: 28)
            Text(text)
                .font(.lullabBody)
                .foregroundStyle(.lullabTextPrimary)
        }
    }
}

struct BabySetupView: View {
    let isOnboarding: Bool
    let onComplete: (() -> Void)?

    @Environment(\.dismiss) private var dismiss
    @State private var babyName: String = ""
    @State private var birthdate: Date = Date()
    @State private var saved: Bool = false

    private let persistence = PersistenceController.shared

    init(isOnboarding: Bool = true, onComplete: (() -> Void)? = nil) {
        self.isOnboarding = isOnboarding
        self.onComplete = onComplete
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.lullabAccent)

                    Text(isOnboarding ? "Meet your baby" : "Edit Baby Profile")
                        .font(.lullabTitle1)
                        .foregroundStyle(.lullabTextPrimary)
                }
                .padding(.top, 32)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                        .font(.lullabBody.bold())
                        .foregroundStyle(.lullabTextPrimary)
                    TextField("Baby's name", text: $babyName)
                        .padding(12)
                        .background(Color.lullabSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.lullabTextPrimary)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Birthdate")
                        .font(.lullabBody.bold())
                        .foregroundStyle(.lullabTextPrimary)
                    DatePicker("", selection: $birthdate, displayedComponents: .date)
                        .labelsHidden()
                        .padding(12)
                        .background(Color.lullabSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                Spacer()

                LullabButton(isOnboarding ? "Start Tracking" : "Save", icon: "checkmark", color: .lullabAccent) {
                    saveBaby()
                }
                .disabled(babyName.isEmpty)
                .opacity(babyName.isEmpty ? 0.5 : 1.0)
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .background(Color.lullabBackground)
            .navigationTitle("")
            .toolbar {
                if !isOnboarding {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") { dismiss() }
                            .foregroundStyle(.lullabAccent)
                    }
                }
            }
            .onAppear { loadExistingBaby() }
        }
    }

    private func saveBaby() {
        if let existing = persistence.fetchBaby() {
            persistence.updateBaby(existing, name: babyName, birthdate: birthdate)
        } else {
            persistence.createBaby(name: babyName, birthdate: birthdate)
        }
        if isOnboarding {
            onComplete?()
        } else {
            dismiss()
        }
    }

    private func loadExistingBaby() {
        if let baby = persistence.fetchBaby() {
            babyName = baby.name ?? ""
            birthdate = baby.birthdate ?? Date()
        }
    }
}
