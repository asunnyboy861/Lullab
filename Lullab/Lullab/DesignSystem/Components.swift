import SwiftUI

struct LullabButton: View {
    let title: String
    let icon: String?
    let color: Color
    let action: () -> Void

    init(_ title: String, icon: String? = nil, color: Color = .lullabAccent, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.color = color
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .font(.lullabBody.bold())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(color)
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

struct LullabCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(Color.lullabSurface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct LullabSectionHeader: View {
    let title: String
    let icon: String?
    let color: Color

    init(_ title: String, icon: String? = nil, color: Color = .lullabTextPrimary) {
        self.title = title
        self.icon = icon
        self.color = color
    }

    var body: some View {
        HStack(spacing: 6) {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(color)
            }
            Text(title)
                .font(.lullabTitle3)
                .foregroundStyle(.lullabTextPrimary)
            Spacer()
        }
    }
}
