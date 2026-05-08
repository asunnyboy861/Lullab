import SwiftUI

struct FeedDetailView: View {
    @StateObject private var vm = FeedViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    feedTypePicker

                    if vm.feedType == .breast {
                        breastSidePicker
                        durationField
                    } else if vm.feedType == .bottle {
                        volumeField
                    }

                    notesField
                }
                .padding()
            }
            .background(Color.lullabBackground)
            .navigationTitle("Feed Details")
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

    private var feedTypePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Type")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)

            HStack(spacing: 12) {
                ForEach(FeedType.allCases, id: \.self) { type in
                    Button {
                        vm.feedType = type
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: type.icon)
                                .font(.title3)
                            Text(type.displayName)
                                .font(.lullabCaption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(vm.feedType == type ? Color.lullabFeed.opacity(0.3) : Color.lullabSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            if vm.feedType == type {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.lullabFeed, lineWidth: 2)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(vm.feedType == type ? .lullabFeed : .lullabTextSecondary)
                }
            }
        }
    }

    private var breastSidePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Side")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            HStack(spacing: 12) {
                ForEach(BreastSide.allCases, id: \.self) { side in
                    Button {
                        vm.breastSide = side
                    } label: {
                        Text(side.displayName)
                            .font(.lullabBody)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(vm.breastSide == side ? Color.lullabFeed.opacity(0.3) : Color.lullabSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                if vm.breastSide == side {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.lullabFeed, lineWidth: 2)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(vm.breastSide == side ? .lullabFeed : .lullabTextSecondary)
                }
            }
        }
    }

    private var volumeField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Volume (ml)")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("0", text: $vm.volume)
                .keyboardType(.decimalPad)
                .padding(12)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
        }
    }

    private var durationField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Duration (minutes)")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("0", text: $vm.duration)
                .keyboardType(.decimalPad)
                .padding(12)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
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
