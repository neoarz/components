//
//  NavBarView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

// MARK: - NavBarView

struct NavBarView: View {
    var onMenuTap: () -> Void = {}
    var onSettingsTap: () -> Void = {}

    var body: some View {
        HStack {
            IconButtonView(
                systemName: "line.3.horizontal",
                style: .dark,
                size: .medium,
                action: onMenuTap
            )
            .accessibilityLabel("Menu")
            .accessibilityIdentifier("nav.menuButton")

            Spacer()

            IconButtonView(
                systemName: "gearshape",
                style: .dark,
                size: .medium,
                action: onSettingsTap
            )
            .accessibilityLabel("Settings")
            .accessibilityIdentifier("nav.settingsButton")
        }
        .padding(AppTheme.Spacing.md)
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
            .previewSurface()
    }
}
