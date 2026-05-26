import Foundation

struct Conversation: Identifiable, Codable, Hashable {
    let id: UUID
    let contactName: String
    let contactAvatar: String
    let lastMessage: String
    let lastMessageDate: Date
    let messages: [ChatMessage]
    let unreadCount: Int

    init(
        id: UUID = UUID(),
        contactName: String,
        contactAvatar: String = "",
        lastMessage: String = "",
        lastMessageDate: Date = Date(),
        messages: [ChatMessage] = [],
        unreadCount: Int = 0
    ) {
        self.id = id
        self.contactName = contactName
        self.contactAvatar = contactAvatar
        self.lastMessage = lastMessage
        self.lastMessageDate = lastMessageDate
        self.messages = messages
        self.unreadCount = unreadCount
    }
}

struct ChatMessage: Identifiable, Codable, Hashable {
    let id: UUID
    let text: String
    let isFromMe: Bool
    let timestamp: Date
    let status: MessageStatus

    init(
        id: UUID = UUID(),
        text: String,
        isFromMe: Bool,
        timestamp: Date = Date(),
        status: MessageStatus = .sent
    ) {
        self.id = id
        self.text = text
        self.isFromMe = isFromMe
        self.timestamp = timestamp
        self.status = status
    }
}

enum MessageStatus: String, Codable, Hashable {
    case sent = "Sent"
    case delivered = "Delivered"
    case read = "Read"
}
