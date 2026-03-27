//
//  CatalogHomeView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct CatalogHomeView: View {
    var body: some View {
        NavigationStack {
            List {
                ComponentsSection()
                ScreensSection()
            }
            .navigationTitle("Components")
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(AppTheme.Colors.background)
        }
    }
}

private struct ComponentsSection: View {
    var body: some View {
        Section("Components") {
            CatalogDestinationRow("IconButton", accessibilityIdentifier: "catalog.iconButton") {
                ComponentPreviewWrapper {
                    VStack(spacing: AppTheme.Spacing.xl) {
                        IconButtonView(systemName: "line.3.horizontal", style: .dark, size: .medium)
                        IconButtonView(systemName: "gearshape", style: .dark, size: .medium)
                        IconButtonView(systemName: "waveform", style: .light, size: .medium)
                    }
                }
                .navigationTitle("IconButton")
            }

            CatalogDestinationRow("NavBar", accessibilityIdentifier: "catalog.navBar") {
                ComponentPreviewWrapper { NavBarView() }
                    .navigationTitle("NavBar")
            }

            CatalogDestinationRow("MessageBubble", accessibilityIdentifier: "catalog.messageBubble") {
                ComponentPreviewWrapper {
                    VStack(spacing: AppTheme.Spacing.md) {
                        MessageBubbleView(text: "Hello World", isFromCurrentUser: true)
                        MessageBubbleView(text: "Hey there! What can i help you with?", isFromCurrentUser: false)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("MessageBubble")
            }

            CatalogDestinationRow("ChatInputBar", accessibilityIdentifier: "catalog.chatInputBar") {
                ComponentPreviewWrapper {
                    ChatInputBarView(
                        text: .constant("")
                    )
                }
                    .navigationTitle("ChatInputBar")
            }

            CatalogDestinationRow("VoiceInputBar", accessibilityIdentifier: "catalog.voiceInputBar") {
                ComponentPreviewWrapper {
                    VoiceInputBarView(
                        isRecording: .constant(false)
                    )
                }
                    .navigationTitle("VoiceInputBar")
            }
        }
    }
}

private struct ScreensSection: View {
    var body: some View {
        Section("Screens") {
            CatalogDestinationRow("Chat Screen", accessibilityIdentifier: "catalog.chatScreen") {
                ChatScreenView(messages: ChatFixtures.demoConversation)
            }

            CatalogDestinationRow("Voice Chat Screen", accessibilityIdentifier: "catalog.voiceChatScreen") {
                VoiceChatScreenView(messages: ChatFixtures.demoConversation)
            }
        }
    }
}

private struct CatalogDestinationRow<Destination: View>: View {
    let title: String
    let accessibilityIdentifier: String
    private let destination: Destination

    init(
        _ title: String,
        accessibilityIdentifier: String,
        @ViewBuilder destination: () -> Destination
    ) {
        self.title = title
        self.accessibilityIdentifier = accessibilityIdentifier
        self.destination = destination()
    }

    var body: some View {
        NavigationLink(title) {
            destination
        }
        .accessibilityLabel(title)
        .accessibilityIdentifier(accessibilityIdentifier)
    }
}

private struct ComponentPreviewWrapper<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewSurface()
    }
}

struct CatalogHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogHomeView()
    }
}
