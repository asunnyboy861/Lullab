import SwiftUI

struct GrowthDetailView: View {
    @StateObject private var vm = GrowthViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    weightField
                    heightField
                    headField
                    notesField

                    LullabButton("Save Growth", icon: "checkmark", color: .lullabGrowth) {
                        vm.save()
                    }
                }
                .padding()
            }
            .background(Color.lullabBackground)
            .navigationTitle("Growth")
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

    private var weightField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weight (kg)")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("0.0", text: $vm.weight)
                .keyboardType(.decimalPad)
                .padding(12)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
        }
    }

    private var heightField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Height (cm)")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("0.0", text: $vm.height)
                .keyboardType(.decimalPad)
                .padding(12)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
        }
    }

    private var headField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Head Circumference (cm)")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("0.0", text: $vm.headCircumference)
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
