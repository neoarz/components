//
//  VoiceChatScreenView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct VoiceChatScreenView: View {
    let messages: [ChatMessage]
    @State private var isRecording = false

    var body: some View {
        ChatScreenLayoutView(messages: messages, bottomChromeBackgroundColor: nil) {
            VoiceScreenBackground()
        } topChrome: {
            NavBarView()
        } inputBar: {
            VoiceInputBarView(isRecording: $isRecording)
        }
    }
}

private enum VoiceBackgroundStyle {
    static let barHeightMultipliers: [CGFloat] = [0.50, 0.28, 0.62, 0.38, 0.24, 0.50]
    static let glowHeight: CGFloat = 250

    static let screenGradient = LinearGradient(
        colors: [
            AppTheme.Colors.voiceBackgroundTop,
            AppTheme.Colors.voiceBackgroundBottom
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    static let glowGradient = LinearGradient(
        colors: [
            AppTheme.Colors.voiceGlowStrong.opacity(0.75),
            AppTheme.Colors.voiceGlowSoft.opacity(0.45),
            .clear
        ],
        startPoint: .bottom,
        endPoint: .top
    )

    static let barGradient = LinearGradient(
        colors: [
            AppTheme.Colors.voiceBarTop.opacity(0.08),
            AppTheme.Colors.voiceBarMiddle.opacity(0.42),
            AppTheme.Colors.voiceBarBottom.opacity(0.72)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}

private struct VoiceScreenBackground: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            VoiceBackgroundStyle.screenGradient

            VoiceBackgroundGlow()
            VoiceBackgroundBars()
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

private struct VoiceBackgroundBars: View {
    var body: some View {
        GeometryReader { proxy in
            let barCount = CGFloat(VoiceBackgroundStyle.barHeightMultipliers.count)
            let barWidth = proxy.size.width / barCount

            HStack(alignment: .bottom, spacing: 0) {
                ForEach(VoiceBackgroundStyle.barHeightMultipliers.indices, id: \.self) { index in
                    VoiceBackgroundBar(
                        width: barWidth,
                        height: proxy.size.height * VoiceBackgroundStyle.barHeightMultipliers[index]
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

private struct VoiceBackgroundGlow: View {
    var body: some View {
        VoiceBackgroundStyle.glowGradient
            .frame(maxWidth: .infinity)
            .frame(height: VoiceBackgroundStyle.glowHeight, alignment: .bottom)
    }
}

private struct VoiceBackgroundBar: View {
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Rectangle()
            .fill(VoiceBackgroundStyle.barGradient)
            .frame(width: width, height: height)
    }
}

struct VoiceChatScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VoiceChatScreenView(messages: ChatFixtures.demoConversation)
        }
    }
}
