import SwiftUI
import StoreKit

struct PremiumPaywallView: View {
    @ObservedObject var subscription: SubscriptionManager
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPlan: String = SubscriptionManager.yearlyID
    @State private var isPurchasing = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    featuresSection
                    planSelector
                    subscribeButton
                    restoreButton
                    disclaimerText
                }
                .padding()
            }
            .background(Color.lullabBackground)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(.lullabAccent)
                }
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "crown.fill")
                .font(.system(size: 48))
                .foregroundStyle(.lullabAccent)

            Text("Lullab Premium")
                .font(.lullabLargeTitle)
                .foregroundStyle(.lullabTextPrimary)

            Text("Unlock everything for your baby's journey")
                .font(.lullabBody)
                .foregroundStyle(.lullabTextSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }

    private var featuresSection: some View {
        VStack(spacing: 12) {
            FeatureRow(icon: "infinity", color: .lullabFeed, title: "Unlimited History", subtitle: "Access all past events")
            FeatureRow(icon: "chart.xyaxis.line", color: .lullabGrowth, title: "WHO Growth Charts", subtitle: "Percentile tracking")
            FeatureRow(icon: "doc.richtext", color: .lullabSleep, title: "Doctor Reports", subtitle: "PDF export for visits")
            FeatureRow(icon: "chart.bar", color: .lullabDiaper, title: "Trend Analysis", subtitle: "Weekly summaries & insights")
        }
    }

    private var planSelector: some View {
        VStack(spacing: 12) {
            if let monthly = subscription.monthlyProduct {
                PlanCard(
                    id: SubscriptionManager.monthlyID,
                    selectedPlan: $selectedPlan,
                    title: "Monthly",
                    price: monthly.displayPrice,
                    subtitle: "per month",
                    badge: nil
                )
            }

            if let yearly = subscription.yearlyProduct {
                PlanCard(
                    id: SubscriptionManager.yearlyID,
                    selectedPlan: $selectedPlan,
                    title: "Yearly",
                    price: yearly.displayPrice,
                    subtitle: "per year — save 44%",
                    badge: "Best Value"
                )
            }
        }
    }

    private var subscribeButton: some View {
        LullabButton(
            isPurchasing ? "Processing..." : "Subscribe",
            icon: "crown.fill",
            color: .lullabAccent
        ) {
            Task { await purchase() }
        }
        .disabled(isPurchasing)
    }

    private var restoreButton: some View {
        Button("Restore Purchases") {
            Task { await subscription.restorePurchases() }
        }
        .font(.lullabCaption)
        .foregroundStyle(.lullabAccent)
    }

    private var disclaimerText: some View {
        Text("Payment will be charged to your Apple ID account at confirmation of purchase. Subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions by going to your account settings on the App Store after purchase.")
            .font(.system(size: 10, design: .rounded))
            .foregroundStyle(.lullabTextSecondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
    }

    private func purchase() async {
        isPurchasing = true
        let product = subscription.products.first { $0.id == selectedPlan }
        if let product {
            let success = await subscription.purchase(product)
            if success { dismiss() }
        }
        isPurchasing = false
    }
}

struct FeatureRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.lullabBody.bold())
                    .foregroundStyle(.lullabTextPrimary)
                Text(subtitle)
                    .font(.lullabCaption)
                    .foregroundStyle(.lullabTextSecondary)
            }

            Spacer()
        }
        .padding(12)
        .background(Color.lullabSurface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct PlanCard: View {
    let id: String
    @Binding var selectedPlan: String
    let title: String
    let price: String
    let subtitle: String
    let badge: String?

    var body: some View {
        Button {
            selectedPlan = id
        } label: {
            HStack(spacing: 12) {
                Circle()
                    .stroke(selectedPlan == id ? Color.lullabAccent : Color.lullabSeparator, lineWidth: 2)
                    .fill(selectedPlan == id ? Color.lullabAccent : Color.clear)
                    .frame(width: 22, height: 22)
                    .overlay {
                        if selectedPlan == id {
                            Image(systemName: "checkmark")
                                .font(.caption2.bold())
                                .foregroundStyle(.black)
                        }
                    }

                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(title)
                            .font(.lullabBody.bold())
                            .foregroundStyle(.lullabTextPrimary)
                        if let badge {
                            Text(badge)
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.lullabAccent)
                                .foregroundStyle(.black)
                                .clipShape(Capsule())
                        }
                    }
                    Text(subtitle)
                        .font(.lullabCaption)
                        .foregroundStyle(.lullabTextSecondary)
                }

                Spacer()

                Text(price)
                    .font(.lullabTitle3.bold())
                    .foregroundStyle(.lullabTextPrimary)
            }
            .padding(14)
            .background(selectedPlan == id ? Color.lullabAccent.opacity(0.1) : Color.lullabSurface)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedPlan == id ? Color.lullabAccent : Color.clear, lineWidth: 2)
            }
        }
        .buttonStyle(.plain)
    }
}
