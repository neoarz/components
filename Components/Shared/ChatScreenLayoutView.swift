//
//  ChatScreenLayoutView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

private enum ChatScreenLayoutMetrics {
    static let chromeHorizontalPadding: CGFloat = 16
}

struct ChatScreenLayoutView<TopChrome: View, InputBar: View, BackgroundContent: View>: View {
    private let messages: [ChatMessage]
    private let topChromeBackgroundColor: Color?
    private let bottomChromeBackgroundColor: Color?
    private let backgroundContent: BackgroundContent
    private let topChrome: TopChrome
    private let inputBar: InputBar

    init(
        messages: [ChatMessage],
        topChromeBackgroundColor: Color? = AppTheme.Colors.background.opacity(0.96),
        bottomChromeBackgroundColor: Color? = AppTheme.Colors.background.opacity(0.96),
        @ViewBuilder backgroundContent: () -> BackgroundContent,
        @ViewBuilder topChrome: () -> TopChrome,
        @ViewBuilder inputBar: () -> InputBar
    ) {
        self.messages = messages
        self.topChromeBackgroundColor = topChromeBackgroundColor
        self.bottomChromeBackgroundColor = bottomChromeBackgroundColor
        self.backgroundContent = backgroundContent()
        self.topChrome = topChrome()
        self.inputBar = inputBar()
    }

    var body: some View {
        MessageListView(messages: messages)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                ScreenBackground {
                    backgroundContent
                }
            }
            .overlay(alignment: .top) {
                TopSafeAreaBackground(color: topChromeBackgroundColor)
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                ChromeContainer(backgroundColor: topChromeBackgroundColor) {
                    topChrome
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                ChromeContainer(backgroundColor: bottomChromeBackgroundColor) {
                    inputBar
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .enableInteractivePopGesture()
    }
}

extension ChatScreenLayoutView where BackgroundContent == EmptyView {
    init(
        messages: [ChatMessage],
        topChromeBackgroundColor: Color? = AppTheme.Colors.background.opacity(0.96),
        bottomChromeBackgroundColor: Color? = AppTheme.Colors.background.opacity(0.96),
        @ViewBuilder topChrome: () -> TopChrome,
        @ViewBuilder inputBar: () -> InputBar
    ) {
        self.init(
            messages: messages,
            topChromeBackgroundColor: topChromeBackgroundColor,
            bottomChromeBackgroundColor: bottomChromeBackgroundColor,
            backgroundContent: { EmptyView() },
            topChrome: topChrome,
            inputBar: inputBar
        )
    }
}

private struct ScreenBackground<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            AppTheme.Colors.background.ignoresSafeArea()
            content
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

private struct TopSafeAreaBackground: View {
    let color: Color?

    var body: some View {
        GeometryReader { proxy in
            if let color {
                color
                    .frame(height: proxy.safeAreaInsets.top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .ignoresSafeArea(edges: .top)
            }
        }
        .allowsHitTesting(false)
    }
}

private struct ChromeContainer<Content: View>: View {
    private let backgroundColor: Color?
    private let content: Content

    init(
        backgroundColor: Color? = AppTheme.Colors.background.opacity(0.96),
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }

    var body: some View {
        content
            .padding(.horizontal, ChatScreenLayoutMetrics.chromeHorizontalPadding)
            .padding(.vertical, AppTheme.Spacing.sm)
            .background {
                if let backgroundColor {
                    backgroundColor
                }
            }
    }
}
