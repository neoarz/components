//
//  ChatMessage.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import Foundation

struct ChatMessage: Identifiable, Hashable {
    enum Sender: Hashable {
        case currentUser
        case assistant
    }

    let id: UUID
    let text: String
    let sender: Sender

    init(id: UUID = UUID(), text: String, sender: Sender) {
        self.id = id
        self.text = text
        self.sender = sender
    }

    var isFromCurrentUser: Bool {
        sender == .currentUser
    }
}
