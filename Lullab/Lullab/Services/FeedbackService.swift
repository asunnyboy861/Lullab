import Foundation

struct FeedbackRequest: Codable {
    let name: String
    let email: String
    let subject: String
    let message: String
    let app_name: String
}

final class FeedbackService {
    static let shared = FeedbackService()
    private let baseURL = "https://feedback-board.iocompile67692.workers.dev"

    func submit(name: String, email: String, subject: String, message: String) async throws -> Bool {
        let request = FeedbackRequest(
            name: name,
            email: email,
            subject: subject,
            message: message,
            app_name: "Lullab"
        )

        var urlRequest = URLRequest(url: URL(string: "\(baseURL)/api/feedback")!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (_, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            return false
        }
        return true
    }
}
