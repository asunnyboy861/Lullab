import SwiftUI

struct DiaperDetailView: View {
    @StateObject private var vm = DiaperViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    typePicker
                    colorPicker
                    notesField

                    LullabButton("Save Diaper", icon: "checkmark", color: .lullabDiaper) {
                        vm.save()
                    }
                }
                .padding()
            }
            .background(Color.lullabBackground)
            .navigationTitle("Diaper")
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

    private var typePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Type")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)

            HStack(spacing: 12) {
                ForEach(DiaperType.allCases, id: \.self) { type in
                    Button {
                        vm.diaperType = type
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: type.icon)
                                .font(.title3)
                            Text(type.displayName)
                                .font(.lullabCaption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(vm.diaperType == type ? Color.lullabDiaper.opacity(0.3) : Color.lullabSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            if vm.diaperType == type {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.lullabDiaper, lineWidth: 2)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(vm.diaperType == type ? .lullabDiaper : .lullabTextSecondary)
                }
            }
        }
    }

    private var colorPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Color")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(DiaperColor.allCases, id: \.self) { c in
                        Button {
                            vm.color = c
                        } label: {
                            Text(c.displayName)
                                .font(.lullabCaption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(vm.color == c ? Color.lullabDiaper.opacity(0.3) : Color.lullabSurface)
                                .clipShape(Capsule())
                                .overlay {
                                    if vm.color == c {
                                        Capsule()
                                            .stroke(Color.lullabDiaper, lineWidth: 2)
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(vm.color == c ? .lullabDiaper : .lullabTextSecondary)
                    }
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
