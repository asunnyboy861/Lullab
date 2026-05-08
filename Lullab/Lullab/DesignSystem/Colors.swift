import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension ShapeStyle where Self == Color {
    static var lullabBackground: Color { Color(hex: "000000") }
    static var lullabSurface: Color { Color(hex: "1C1C1E") }
    static var lullabSurfaceElevated: Color { Color(hex: "2C2C2E") }
    static var lullabTextPrimary: Color { Color(hex: "FFFFFF") }
    static var lullabTextSecondary: Color { Color(hex: "8E8E93") }
    static var lullabSeparator: Color { Color(hex: "38383A") }
    static var lullabFeed: Color { Color(hex: "FF9F0A") }
    static var lullabSleep: Color { Color(hex: "0A84FF") }
    static var lullabDiaper: Color { Color(hex: "30D158") }
    static var lullabGrowth: Color { Color(hex: "BF5AF2") }
    static var lullabAccent: Color { Color(hex: "FFD60A") }
    static var lullabLightBackground: Color { Color(hex: "F2F2F7") }
    static var lullabLightSurface: Color { Color(hex: "FFFFFF") }
    static var lullabLightTextPrimary: Color { Color(hex: "000000") }
    static var lullabLightTextSecondary: Color { Color(hex: "636366") }
}
