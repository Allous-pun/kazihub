import SwiftUI

struct ChatView: View {
    let conversation: Conversation
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss
    @State private var messageText: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            VStack(spacing: 0) {
                messagesList
                composeBar
            }
        }
        .navigationTitle(conversation.contactName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(ThemeManager.gold.opacity(0.2))
                        .frame(width: 32, height: 32)
                        .overlay {
                            Text(initials)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(ThemeManager.gold)
                        }

                    VStack(alignment: .leading, spacing: 1) {
                        Text(conversation.contactName)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(themeManager.textPrimary)

                        Text("Online")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.green)
                    }
                }
            }
        }
    }

    private var messagesList: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(conversation.messages) { message in
                    ChatBubble(message: message)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .defaultScrollAnchor(.bottom)
    }

    private var composeBar: some View {
        HStack(spacing: 10) {
            HStack {
                TextField("Type a message...", text: $messageText)
                    .font(.system(size: 15))
                    .foregroundStyle(themeManager.textPrimary)
                    .focused($isFocused)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
            }
            .background {
                RoundedRectangle(cornerRadius: 22)
                    .fill(themeManager.surface)
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(themeManager.textSecondary.opacity(0.1), lineWidth: 1)
                    }
            }

            Button {
                // Send action
                messageText = ""
                isFocused = false
            } label: {
                ZStack {
                    Circle()
                        .fill(messageText.isEmpty ? themeManager.surfaceSecondary : ThemeManager.gold)
                        .frame(width: 42, height: 42)

                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(messageText.isEmpty ? themeManager.textSecondary : .white)
                }
            }
            .disabled(messageText.isEmpty)
            .animation(.easeInOut(duration: 0.2), value: messageText.isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background {
            Rectangle()
                .fill(themeManager.surface)
                .overlay(alignment: .top) {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundStyle(themeManager.textSecondary.opacity(0.1))
                }
                .ignoresSafeArea(edges: .bottom)
        }
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

struct ChatBubble: View {
    let message: ChatMessage
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        HStack {
            if message.isFromMe { Spacer(minLength: 60) }

            VStack(alignment: message.isFromMe ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.system(size: 15))
                    .foregroundStyle(message.isFromMe ? .white : themeManager.textPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                message.isFromMe
                                    ? ThemeManager.gold
                                    : themeManager.surface
                            )
                            .overlay {
                                if !message.isFromMe {
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(themeManager.textSecondary.opacity(0.08), lineWidth: 1)
                                }
                            }
                    }

                HStack(spacing: 4) {
                    Text(message.timestamp, style: .time)
                        .font(.system(size: 10))
                        .foregroundStyle(themeManager.textSecondary.opacity(0.5))

                    if message.isFromMe {
                        Image(systemName: message.status == .read ? "checkmark.circle.fill" : "checkmark")
                            .font(.system(size: 10))
                            .foregroundStyle(message.status == .read ? ThemeManager.gold : themeManager.textSecondary.opacity(0.4))
                    }
                }
                .padding(.horizontal, 4)
            }

            if !message.isFromMe { Spacer(minLength: 60) }
        }
    }
}
