//
//  MessageListView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct MessageListView: View {
    let messages: [ChatMessage]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: AppTheme.Spacing.md) {
                ForEach(messages) { message in
                    MessageBubbleView(
                        text: message.text,
                        isFromCurrentUser: message.isFromCurrentUser
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, AppTheme.Spacing.xl)
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(messages: ChatFixtures.demoConversation)
            .previewSurface()
    }
}
