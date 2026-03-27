//
//  VoiceInputBarView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct VoiceInputBarView: View {
    @Binding var isRecording: Bool
    let attachmentActions: [AttachmentMenuAction]
    let onKeyboardTap: () -> Void
    let onRecorderTap: () -> Void

    init(
        isRecording: Binding<Bool>,
        attachmentActions: [AttachmentMenuAction] = AttachmentMenuAction.standardOptions,
        onKeyboardTap: @escaping () -> Void = {},
        onRecorderTap: @escaping () -> Void = {}
    ) {
        self._isRecording = isRecording
        self.attachmentActions = attachmentActions
        self.onKeyboardTap = onKeyboardTap
        self.onRecorderTap = onRecorderTap
    }

    var body: some View {
        HStack {
            AttachmentMenuButton(size: .large, actions: attachmentActions)

            Spacer()

            VoiceInputActionCluster(
                onKeyboardTap: onKeyboardTap,
                isRecording: isRecording,
                onRecorderTap: toggleRecordingState
            )
        }
        .padding(AppTheme.Spacing.md)
    }

    private func toggleRecordingState() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isRecording.toggle()
        }
        onRecorderTap()
    }
}

private struct VoiceInputActionCluster: View {
    let onKeyboardTap: () -> Void
    let isRecording: Bool
    let onRecorderTap: () -> Void

    var body: some View {
        HStack(spacing: AppTheme.Spacing.xl) {
            IconButtonView(
                systemName: "keyboard",
                style: .dark,
                size: .large,
                action: onKeyboardTap
            )
            .accessibilityLabel("Keyboard")
            .accessibilityIdentifier("voice.keyboardButton")

            VoiceRecorderButton(
                isRecording: isRecording,
                size: .large,
                action: onRecorderTap
            )
        }
    }
}

private struct VoiceRecorderButton: View {
    let isRecording: Bool
    let size: IconButtonSize
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                VoiceRecorderIcon(
                    systemName: "mic",
                    color: AppTheme.Colors.iconOnLightSurface,
                    size: size,
                    opacity: isRecording ? 0 : 1
                )

                VoiceRecorderIcon(
                    systemName: "stop.fill",
                    color: AppTheme.Colors.destructive,
                    size: size,
                    opacity: isRecording ? 1 : 0
                )
            }
                .frame(width: size.buttonDimension, height: size.buttonDimension)
        }
        .buttonStyle(.plain)
        .lightCardStyle()
        .animation(.easeInOut(duration: 0.2), value: isRecording)
        .accessibilityLabel(isRecording ? "Stop recording" : "Start recording")
        .accessibilityIdentifier("voice.recorderButton")
    }
}

private struct VoiceRecorderIcon: View {
    let systemName: String
    let color: Color
    let size: IconButtonSize
    let opacity: Double

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: size.iconDimension, height: size.iconDimension)
            .foregroundStyle(color)
            .opacity(opacity)
    }
}

struct VoiceInputBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VoiceInputBarView(isRecording: .constant(false))
                .previewSurface()
                .previewDisplayName("Idle")

            VoiceInputBarView(isRecording: .constant(true))
                .previewSurface()
                .previewDisplayName("Recording")
        }
    }
}
