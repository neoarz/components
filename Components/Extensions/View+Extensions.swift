//
//  View+Extensions.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI
import UIKit

// MARK: - Card Styles

extension View {
    func darkCardStyle(cornerRadius: CGFloat = AppTheme.Radius.pill) -> some View {
        self
            .background(AppTheme.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(AppTheme.Colors.border, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 1)
    }

    func lightCardStyle(cornerRadius: CGFloat = AppTheme.Radius.action) -> some View {
        self
            .background(AppTheme.Colors.lightSurface)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(AppTheme.Colors.lightBorder, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 1)
    }

    func previewSurface() -> some View {
        self.background(AppTheme.Colors.background)
    }

    func enableInteractivePopGesture() -> some View {
        self.background(InteractivePopGestureEnabler())
    }
}

private struct InteractivePopGestureEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> InteractivePopGestureViewController {
        InteractivePopGestureViewController()
    }

    func updateUIViewController(_ uiViewController: InteractivePopGestureViewController, context: Context) {}
}

private final class InteractivePopGestureViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
