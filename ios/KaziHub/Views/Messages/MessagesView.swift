import SwiftUI

struct MessagesView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var viewModel: MessagesViewModel

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            VStack(spacing: 0) {
                headerSection

                if viewModel.conversations.isEmpty {
                    emptyState
                } else {
                    conversationsList
                }
            }
        }
    }

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Messages")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                if viewModel.totalUnread > 0 {
                    Text("\(viewModel.totalUnread) unread message\(viewModel.totalUnread > 1 ? "s" : "")")
                        .font(.system(size: 14))
                        .foregroundStyle(ThemeManager.gold)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }

    private var conversationsList: some View {
        ScrollView {
            LazyVStack(spacing: 2) {
                ForEach(viewModel.conversations) { conversation in
                    NavigationLink(value: conversation) {
                        ConversationRow(conversation: conversation)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationDestination(for: Conversation.self) { conversation in
            ChatView(conversation: conversation)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "message.fill")
                .font(.system(size: 48))
                .foregroundStyle(themeManager.textSecondary.opacity(0.4))

            Text("No Messages")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            Text("Messages from employers will appear here")
                .font(.system(size: 14))
                .foregroundStyle(themeManager.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ConversationRow: View {
    let conversation: Conversation
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        HStack(spacing: 14) {
            // Avatar
            ZStack {
                Circle()
                    .fill(ThemeManager.gold.opacity(0.2))
                    .frame(width: 50, height: 50)

                Text(initials)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(ThemeManager.gold)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.contactName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(themeManager.textPrimary)

                    Spacer()

                    Text(conversation.lastMessageDate, style: .relative)
                        .font(.system(size: 12))
                        .foregroundStyle(themeManager.textSecondary.opacity(0.6))
                }

                HStack {
                    Text(conversation.lastMessage)
                        .font(.system(size: 14))
                        .foregroundStyle(themeManager.textSecondary)
                        .lineLimit(1)

                    Spacer()

                    if conversation.unreadCount > 0 {
                        Text("\(conversation.unreadCount)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .background(Circle().fill(ThemeManager.gold))
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(themeManager.background)
    }

    private var initials: String {
        conversation.contactName
            .split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }
            .map(String.init)
            .joined()
    }
}
