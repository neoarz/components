//
//  MessageBubbleView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct MessageBubbleView: View {
    let text: String
    let isFromCurrentUser: Bool

    private var horizontalAlignment: Alignment {
        isFromCurrentUser ? .trailing : .leading
    }

    var body: some View {
        Text(text)
            .font(AppTypography.headingSemibold)
            .foregroundStyle(AppTheme.Colors.textPrimary)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.vertical, AppTheme.Spacing.lg)
            .background {
                if isFromCurrentUser {
                    RoundedRectangle(cornerRadius: AppTheme.Radius.bubble)
                        .fill(AppTheme.Colors.surface)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTheme.Radius.bubble)
                                .stroke(AppTheme.Colors.border, lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 1)
                }
            }
            .frame(maxWidth: .infinity, alignment: horizontalAlignment)
    }
}

struct MessageBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageBubbleView(text: "Hello World", isFromCurrentUser: true)
                .padding()
                .previewSurface()
                .previewDisplayName("Sent")

            MessageBubbleView(text: "Hey there! What can i help you with?", isFromCurrentUser: false)
                .padding()
                .previewSurface()
                .previewDisplayName("Received")

            MessageBubbleView(
                text: "This is a longer message to test how the bubble wraps text across multiple lines in the layout.",
                isFromCurrentUser: true
            )
            .padding()
            .previewSurface()
            .previewDisplayName("Long Message")
        }
    }
}
