import SwiftUI
import Combine

@MainActor
final class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    static let shared = ThemeManager()

    private init() {}

    // Primary dark blue palette
    static let navy900 = Color(red: 10/255, green: 22/255, blue: 40/255)
    static let navy800 = Color(red: 17/255, green: 34/255, blue: 59/255)
    static let navy700 = Color(red: 27/255, green: 45/255, blue: 74/255)
    static let navy600 = Color(red: 38/255, green: 58/255, blue: 90/255)

    // Accent gold
    static let gold = Color(red: 245/255, green: 166/255, blue: 35/255)
    static let goldLight = Color(red: 255/255, green: 198/255, blue: 99/255)

    // Status colors
    static let pendingColor = Color(red: 245/255, green: 166/255, blue: 35/255)
    static let viewedColor = Color(red: 59/255, green: 130/255, blue: 246/255)
    static let acceptedColor = Color(red: 52/255, green: 199/255, blue: 89/255)
    static let rejectedColor = Color(red: 255/255, green: 59/255, blue: 48/255)

    // Surface colors
    var background: Color {
        isDarkMode ? Self.navy900 : Color(uiColor: .systemGray6)
    }
    var surface: Color {
        isDarkMode ? Self.navy800 : .white
    }
    var surfaceSecondary: Color {
        isDarkMode ? Self.navy700 : Color(uiColor: .systemGray5)
    }
    var textPrimary: Color {
        isDarkMode ? .white : Self.navy900
    }
    var textSecondary: Color {
        isDarkMode ? Color.white.opacity(0.6) : Self.navy700.opacity(0.7)
    }
    var accent: Color { ThemeManager.gold }
}
