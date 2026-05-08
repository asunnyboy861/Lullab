import SwiftUI

struct SettingsView: View {
    @StateObject private var subscription = SubscriptionManager()
    @State private var showPaywall = false
    @State private var showContact = false
    @State private var babyName: String = ""
    @State private var babyBirthdate: Date = Date()
    @State private var showBabyEdit = false

    private let persistence = PersistenceController.shared
    private let githubUser = "asunnyboy861"
    private let appName = "Lullab"

    var body: some View {
        NavigationStack {
            List {
                babySection
                premiumSection
                supportSection
                legalSection
                aboutSection
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.lullabBackground)
            .navigationTitle("Settings")
            .sheet(isPresented: $showPaywall) { PremiumPaywallView(subscription: subscription) }
            .sheet(isPresented: $showContact) { ContactSupportView() }
            .sheet(isPresented: $showBabyEdit) { BabySetupView(isOnboarding: false) }
            .onAppear { loadBaby() }
        }
    }

    private var babySection: some View {
        Section {
            Button {
                showBabyEdit = true
            } label: {
                HStack(spacing: 12) {
                    Circle()
                        .fill(Color.lullabAccent.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "moon.stars.fill")
                                .foregroundStyle(.lullabAccent)
                        }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(babyName.isEmpty ? "Set up baby" : babyName)
                            .font(.lullabBody.bold())
                            .foregroundStyle(.lullabTextPrimary)
                        if !babyName.isEmpty {
                            Text(babyBirthdate.ageString)
                                .font(.lullabCaption)
                                .foregroundStyle(.lullabTextSecondary)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.lullabTextSecondary)
                        .font(.caption)
                }
            }
        } header: {
            Text("Baby")
                .foregroundStyle(.lullabTextSecondary)
        }
        .listRowBackground(Color.lullabSurface)
    }

    private var premiumSection: some View {
        Section {
            if subscription.isActive {
                HStack {
                    Image(systemName: "crown.fill")
                        .foregroundStyle(.lullabAccent)
                    Text("Premium Active")
                        .font(.lullabBody)
                        .foregroundStyle(.lullabTextPrimary)
                    Spacer()
                }
            } else {
                Button {
                    showPaywall = true
                } label: {
                    HStack {
                        Image(systemName: "crown")
                            .foregroundStyle(.lullabAccent)
                        Text("Upgrade to Premium")
                            .font(.lullabBody)
                            .foregroundStyle(.lullabAccent)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.lullabTextSecondary)
                            .font(.caption)
                    }
                }
            }

            Button {
                Task { await subscription.restorePurchases() }
            } label: {
                HStack {
                    Image(systemName: "arrow.uturn.backward")
                        .foregroundStyle(.lullabTextSecondary)
                    Text("Restore Purchases")
                        .font(.lullabBody)
                        .foregroundStyle(.lullabTextPrimary)
                    Spacer()
                }
            }
        } header: {
            Text("Subscription")
                .foregroundStyle(.lullabTextSecondary)
        }
        .listRowBackground(Color.lullabSurface)
    }

    private var supportSection: some View {
        Section {
            Button {
                showContact = true
            } label: {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundStyle(.lullabSleep)
                    Text("Contact Support")
                        .font(.lullabBody)
                        .foregroundStyle(.lullabTextPrimary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.lullabTextSecondary)
                        .font(.caption)
                }
            }
        } header: {
            Text("Support")
                .foregroundStyle(.lullabTextSecondary)
        }
        .listRowBackground(Color.lullabSurface)
    }

    private var legalSection: some View {
        Section {
            Link(destination: URL(string: "https://\(githubUser).github.io/\(appName)/support.html")!) {
                HStack {
                    Image(systemName: "questionmark.circle")
                        .foregroundStyle(.lullabTextSecondary)
                    Text("Help & Support")
                        .font(.lullabBody)
                        .foregroundStyle(.lullabTextPrimary)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .foregroundStyle(.lullabTextSecondary)
                        .font(.caption)
                }
            }

            Link(destination: URL(string: "https://\(githubUser).github.io/\(appName)/privacy.html")!) {
                HStack {
                    Image(systemName: "hand.raised")
                        .foregroundStyle(.lullabTextSecondary)
                    Text("Privacy Policy")
                        .font(.lullabBody)
                        .foregroundStyle(.lullabTextPrimary)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .foregroundStyle(.lullabTextSecondary)
                        .font(.caption)
                }
            }

            Link(destination: URL(string: "https://\(githubUser).github.io/\(appName)/terms.html")!) {
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundStyle(.lullabTextSecondary)
                    Text("Terms of Use")
                        .font(.lullabBody)
                        .foregroundStyle(.lullabTextPrimary)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .foregroundStyle(.lullabTextSecondary)
                        .font(.caption)
                }
            }
        } header: {
            Text("Legal")
                .foregroundStyle(.lullabTextSecondary)
        }
        .listRowBackground(Color.lullabSurface)
    }

    private var aboutSection: some View {
        Section {
            HStack {
                Text("Version")
                    .font(.lullabBody)
                    .foregroundStyle(.lullabTextPrimary)
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                    .font(.lullabBody)
                    .foregroundStyle(.lullabTextSecondary)
            }
        } header: {
            Text("About")
                .foregroundStyle(.lullabTextSecondary)
        }
        .listRowBackground(Color.lullabSurface)
    }

    private func loadBaby() {
        if let baby = persistence.fetchBaby() {
            babyName = baby.name ?? ""
            babyBirthdate = baby.birthdate ?? Date()
        }
    }
}
