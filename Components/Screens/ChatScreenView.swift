//
//  ChatScreenView.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct ChatScreenView: View {
    let messages: [ChatMessage]
    @State private var inputText = ""

    var body: some View {
        ChatScreenLayoutView(messages: messages) {
            NavBarView()
        } inputBar: {
            ChatInputBarView(text: $inputText)
        }
    }
}

struct ChatScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatScreenView(messages: ChatFixtures.demoConversation)
        }
    }
}
