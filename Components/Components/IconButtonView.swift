//
//  IconButtonView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI


enum IconButtonStyle {
    case dark
    case light
}

enum IconButtonSize {
    case large
    case medium
    case small

    var buttonDimension: CGFloat {
        switch self {
        case .large: return AppTheme.ButtonSize.large
        case .medium: return AppTheme.ButtonSize.medium
        case .small: return AppTheme.ButtonSize.small
        }
    }

    var iconDimension: CGFloat {
        switch self {
        case .large: return AppTheme.ButtonSize.iconLarge
        case .medium: return AppTheme.ButtonSize.iconMedium
        case .small: return AppTheme.ButtonSize.iconSmall
        }
    }
}

struct IconButtonView: View {
    let systemName: String
    var style: IconButtonStyle = .dark
    var size: IconButtonSize = .medium
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(
                    width: size.iconDimension,
                    height: size.iconDimension
                )
                .foregroundStyle(iconColor)
                .frame(
                    width: size.buttonDimension,
                    height: size.buttonDimension
                )
        }
        .buttonStyle(.plain)
        .modifier(CardStyleModifier(style: style))
    }

    private var iconColor: Color {
        switch style {
        case .dark: return AppTheme.Colors.textPrimary
        case .light: return AppTheme.Colors.iconOnLightSurface
        }
    }
}


private struct CardStyleModifier: ViewModifier {
    let style: IconButtonStyle

    @ViewBuilder
    func body(content: Content) -> some View {
        switch style {
        case .dark:
            content.darkCardStyle()
        case .light:
            content.lightCardStyle()
        }
    }
}


struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IconButtonView(systemName: "line.3.horizontal", style: .dark, size: .large)
                .padding()
                .previewSurface()
                .previewDisplayName("Dark - Large")

            IconButtonView(systemName: "mic", style: .dark, size: .medium)
                .padding()
                .previewSurface()
                .previewDisplayName("Dark - Medium")

            IconButtonView(systemName: "waveform", style: .light, size: .medium)
                .padding()
                .previewSurface()
                .previewDisplayName("Light - Medium")

            IconButtonView(systemName: "stop.fill", style: .light, size: .small)
                .padding()
                .previewSurface()
                .previewDisplayName("Light - Small")
        }
    }
}
