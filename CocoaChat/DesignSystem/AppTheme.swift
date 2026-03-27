import SwiftUI

enum AppTheme {
    static let background = Color(hex: 0xF3F5F7)
    static let surface = Color(hex: 0xFFFFFF)
    static let surfaceMuted = Color(hex: 0xE9EEF2)
    static let surfaceStrong = Color(hex: 0xDDE5EB)

    static let textPrimary = Color(hex: 0x111418)
    static let textSecondary = Color(hex: 0x66707A)
    static let textSoft = Color(hex: 0x94A0AA)

    static let accent = Color(hex: 0x2F6F5F)
    static let accentHover = Color(hex: 0x285E50)
    static let accentSoft = Color(hex: 0xD8E9E2)

    static let olive = Color(hex: 0x2F6F5F)
    static let oliveSoft = Color(hex: 0xD8E9E2)
    static let warningSoft = Color(hex: 0xEEF4F2)
    static let error = Color(hex: 0xB34B4B)

    static let userBubble = Color(hex: 0x1D232B)
    static let userText = Color(hex: 0xF8FAFC)
    static let modelBubble = Color(hex: 0xFFFFFF)
    static let modelBorder = Color(hex: 0xD9E0E6)
    static let modelText = Color(hex: 0x13171B)

    static let divider = Color(hex: 0xE1E7EC)

    static let pageGradient = LinearGradient(
        colors: [background, surfaceMuted],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

extension Font {
    static let appLargeTitle = Font.system(size: 30, weight: .semibold, design: .rounded)
    static let appTitle = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let appBody = Font.system(size: 16, weight: .regular, design: .default)
    static let appCaption = Font.system(size: 13, weight: .medium, design: .default)
}
