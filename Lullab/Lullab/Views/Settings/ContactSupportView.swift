import SwiftUI

struct ContactSupportView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedSubject: String = "Other"
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var isSubmitting: Bool = false
    @State private var showSuccess: Bool = false
    @State private var showError: Bool = false

    private let subjects = [
        "Feature Suggestion",
        "Bug Report",
        "Usage Question",
        "Performance Issue",
        "UI Improvement",
        "Other"
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    subjectSelector
                    nameField
                    emailField
                    messageField
                    submitButton
                }
                .padding()
            }
            .background(Color.lullabBackground)
            .navigationTitle("Contact Support")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(.lullabAccent)
                }
            }
            .alert("Thank you!", isPresented: $showSuccess) {
                Button("OK") { dismiss() }
            } message: {
                Text("Your feedback has been submitted. We'll get back to you soon.")
            }
            .alert("Error", isPresented: $showError) {
                Button("OK") {}
            } message: {
                Text("Failed to submit feedback. Please try again later.")
            }
        }
    }

    private var subjectSelector: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Subject")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8)
            ], spacing: 8) {
                ForEach(subjects, id: \.self) { subject in
                    Button {
                        selectedSubject = subject
                    } label: {
                        Text(subject)
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(selectedSubject == subject ? Color.lullabAccent : Color.lullabSurface)
                            .foregroundStyle(selectedSubject == subject ? .black : .lullabTextSecondary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("Your name", text: $name)
                .padding(12)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
        }
    }

    private var emailField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextField("your@email.com", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .padding(12)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
        }
    }

    private var messageField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Message")
                .font(.lullabBody.bold())
                .foregroundStyle(.lullabTextPrimary)
            TextEditor(text: $message)
                .frame(minHeight: 120)
                .padding(8)
                .background(Color.lullabSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.lullabTextPrimary)
                .scrollContentBackground(.hidden)
        }
    }

    private var submitButton: some View {
        LullabButton(
            isSubmitting ? "Submitting..." : "Submit Feedback",
            icon: "paperplane.fill",
            color: .lullabAccent
        ) {
            submitFeedback()
        }
        .disabled(isSubmitting || name.isEmpty || email.isEmpty || message.isEmpty)
        .opacity((name.isEmpty || email.isEmpty || message.isEmpty) ? 0.5 : 1.0)
    }

    private func submitFeedback() {
        isSubmitting = true
        Task {
            do {
                let success = try await FeedbackService.shared.submit(
                    name: name,
                    email: email,
                    subject: selectedSubject,
                    message: message
                )
                isSubmitting = false
                if success {
                    showSuccess = true
                } else {
                    showError = true
                }
            } catch {
                isSubmitting = false
                showError = true
            }
        }
    }
}
