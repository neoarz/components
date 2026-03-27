//
//  Theme.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI
import UIKit

// MARK: - Design Tokens

enum AppTheme {
    enum Colors {
        static let background = Color.dynamic(light: 0xF3F5F4, dark: 0x0A0A0A)
        static let surface = Color.dynamic(light: 0xFFFFFF, dark: 0x171717)
        static let border = Color.dynamic(light: 0xD8DEDB, dark: 0x262626)
        static let textPrimary = Color.dynamic(light: 0x111827, dark: 0xFAFAFA)
        static let textSecondary = Color.dynamic(light: 0x66716C, dark: 0xE5E5E5)
        static let iconOnLightSurface = Color.dynamic(light: 0x111827, dark: 0x171717)
        static let lightSurface = Color.dynamic(light: 0xFFFFFF, dark: 0xFAFAFA)
        static let lightBorder = Color.dynamic(light: 0xD1D5DB, dark: 0xE5E5E5)
        static let destructive = Color.dynamic(light: 0xDC2626, dark: 0xEF4444)

        static let voiceBackgroundTop = Color.dynamic(light: 0xF8FBF9, dark: 0x000000)
        static let voiceBackgroundBottom = Color.dynamic(light: 0xDDEEE4, dark: 0x051E14)
        static let voiceGlowStrong = Color.dynamic(light: 0x8BC6A4, dark: 0x1A543B)
        static let voiceGlowSoft = Color.dynamic(light: 0xB8DDC8, dark: 0x103324)
        static let voiceBarTop = Color.dynamic(light: 0xD4E9DC, dark: 0x081A14)
        static let voiceBarMiddle = Color.dynamic(light: 0xA4CCB4, dark: 0x0A2E21)
        static let voiceBarBottom = Color.dynamic(light: 0x7EB698, dark: 0x144835)
    }

    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 15
        static let xl: CGFloat = 20
    }

    enum Radius {
        static let pill: CGFloat = 9999
        static let bubble: CGFloat = 14
        static let action: CGFloat = 999
    }

    enum ButtonSize {
        static let large: CGFloat = 64
        static let medium: CGFloat = 44
        static let small: CGFloat = 32
        static let iconLarge: CGFloat = 24
        static let iconMedium: CGFloat = 20
        static let iconSmall: CGFloat = 16
    }
}

// MARK: - Color Hex Initializer

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    static func dynamic(light: UInt, dark: UInt, alpha: Double = 1.0) -> Color {
        Color(
            uiColor: UIColor { traitCollection in
                UIColor(
                    hex: traitCollection.userInterfaceStyle == .dark ? dark : light,
                    alpha: alpha
                )
            }
        )
    }
}

private extension UIColor {
    convenience init(hex: UInt, alpha: Double = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255
        let green = CGFloat((hex >> 8) & 0xFF) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
