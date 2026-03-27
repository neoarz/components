//
//  AttachmentMenuButton.swift
//  Components
//
//  Created by Neo on 3/27/26.
//

import SwiftUI

struct AttachmentMenuAction: Identifiable {
    let id: String
    let title: String
    let action: () -> Void

    init(id: String? = nil, title: String, action: @escaping () -> Void = {}) {
        self.id = id ?? title
        self.title = title
        self.action = action
    }
}

extension AttachmentMenuAction {
    static let standardOptions: [AttachmentMenuAction] = [
        AttachmentMenuAction(title: "Photos"),
        AttachmentMenuAction(title: "Files"),
        AttachmentMenuAction(title: "Take a Picture")
    ]
}

struct AttachmentMenuButton: View {
    var size: IconButtonSize = .medium
    let actions: [AttachmentMenuAction]

    var body: some View {
        Menu {
            ForEach(actions) { action in
                Button(action.title, action: action.action)
            }
        } label: {
            IconButtonView(
                systemName: "plus",
                style: .dark,
                size: size
            )
        }
        .accessibilityLabel("Attachments")
        .accessibilityIdentifier("attachment.menuButton")
    }
}

struct AttachmentMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AttachmentMenuButton(actions: AttachmentMenuAction.standardOptions)
                .previewSurface()
                .previewDisplayName("Medium")

            AttachmentMenuButton(size: .large, actions: AttachmentMenuAction.standardOptions)
                .previewSurface()
                .previewDisplayName("Large")
        }
    }
}
