//
//  ChatFixtures.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import Foundation

enum ChatFixtures {
    static let demoConversation: [ChatMessage] = [
        ChatMessage(text: "Hello World", sender: .currentUser),
        ChatMessage(text: "Hey there! What can i help you with?", sender: .assistant)
    ]
}
