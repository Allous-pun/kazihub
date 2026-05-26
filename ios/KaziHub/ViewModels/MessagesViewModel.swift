import SwiftUI
import Combine

@MainActor
final class MessagesViewModel: ObservableObject {
    @Published var conversations: [Conversation] = MockDataService.conversations

    var totalUnread: Int {
        conversations.reduce(0) { $0 + $1.unreadCount }
    }
}
