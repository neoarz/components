//
//  ChatInputBarView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct ChatInputBarView: View {
    @Binding var text: String
    var attachmentActions: [AttachmentMenuAction] = AttachmentMenuAction.standardOptions
    var onMicTap: () -> Void = {}
    var onVoiceTap: () -> Void = {}

    var body: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            AttachmentMenuButton(actions: attachmentActions)

            ChatComposerField(
                text: $text,
                onMicTap: onMicTap,
                onVoiceTap: onVoiceTap
            )
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, AppTheme.Spacing.xs)
        .padding(.vertical, AppTheme.Spacing.md)
    }
}

private enum ChatComposerStyle {
    static let textSize: CGFloat = 15
    static let placeholderOpacity = 0.55
    static let leadingPadding: CGFloat = 12
    static let micIconSize: CGFloat = 20
}

private struct ChatComposerField: View {
    @Binding var text: String
    var onMicTap: () -> Void
    var onVoiceTap: () -> Void

    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            ChatComposerTextField(text: $text)
            ChatComposerActions(onMicTap: onMicTap, onVoiceTap: onVoiceTap)
        }
        .frame(minHeight: AppTheme.ButtonSize.medium)
        .darkCardStyle()
    }
}

private struct ChatComposerTextField: View {
    @Binding var text: String

    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text("Type a prompt")
                .foregroundStyle(AppTheme.Colors.textSecondary.opacity(ChatComposerStyle.placeholderOpacity))
        )
        .font(.system(size: ChatComposerStyle.textSize, weight: .regular))
        .foregroundStyle(AppTheme.Colors.textPrimary)
        .textFieldStyle(.plain)
        .accessibilityLabel("Type a prompt")
        .accessibilityIdentifier("chat.promptField")
        .padding(.leading, ChatComposerStyle.leadingPadding)
        .padding(.vertical, AppTheme.Spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct ChatComposerActions: View {
    let onMicTap: () -> Void
    let onVoiceTap: () -> Void

    var body: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Button(action: onMicTap) {
                Image(systemName: "mic")
                    .font(.system(size: ChatComposerStyle.micIconSize, weight: .semibold))
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                    .frame(width: AppTheme.ButtonSize.medium, height: AppTheme.ButtonSize.medium)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Microphone")
            .accessibilityIdentifier("chat.microphoneButton")
            .padding(.leading, AppTheme.Spacing.sm)

            IconButtonView(
                systemName: "waveform",
                style: .light,
                size: .small,
                action: onVoiceTap
            )
            .accessibilityLabel("Voice mode")
            .accessibilityIdentifier("chat.voiceModeButton")
        }
        .padding(.trailing, AppTheme.Spacing.sm)
    }
}

struct ChatInputBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatInputBarView(text: .constant(""))
                .previewSurface()
                .previewDisplayName("Empty")

            ChatInputBarView(text: .constant("Hey (ai name trust), can you help me with"))
                .previewSurface()
                .previewDisplayName("With Text")
        }
    }
}
