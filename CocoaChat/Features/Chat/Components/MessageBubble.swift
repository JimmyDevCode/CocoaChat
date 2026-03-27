import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.role == .user {
                Spacer(minLength: 44)
            }

            Text(message.text)
                .font(.appBody)
                .foregroundStyle(foregroundColor)
                .textSelection(.enabled)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(bubbleBackground)
                .overlay(alignment: .center) {
                    if message.role == .assistant {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(AppTheme.modelBorder, lineWidth: 1)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .frame(maxWidth: 320, alignment: message.role == .user ? .trailing : .leading)

            if message.role == .assistant {
                Spacer(minLength: 44)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var foregroundColor: Color {
        message.role == .user ? AppTheme.userText : AppTheme.modelText
    }

    @ViewBuilder
    private var bubbleBackground: some View {
        if message.role == .user {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(AppTheme.userBubble)
        } else {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(AppTheme.modelBubble)
        }
    }
}
