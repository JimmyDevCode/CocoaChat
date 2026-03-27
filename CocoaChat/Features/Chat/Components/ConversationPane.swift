import SwiftUI

private enum ConversationScrollTarget: Hashable {
    case bottom
}

struct ConversationPane: View {
    let messages: [ChatMessage]
    let promptChips: [PromptChip]
    let isGenerating: Bool
    let isCompact: Bool
    let onPromptTap: (PromptChip) -> Void
    let onBackgroundTap: () -> Void

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    if messages.isEmpty {
                        emptyState
                    } else {
                        LazyVStack(spacing: 14) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                            }

                            if isGenerating {
                                TypingBubble()
                            }

                            Color.clear
                                .frame(height: 1)
                                .id(ConversationScrollTarget.bottom)
                        }
                        .padding(.horizontal, 14)
                        .padding(.top, 16)
                        .padding(.bottom, 18)
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 0)
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
            .simultaneousGesture(
                TapGesture().onEnded {
                    onBackgroundTap()
                }
            )
            .background(conversationBackground)
            .onChange(of: messages.count) { _, _ in
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: isGenerating) { _, _ in
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: isCompact) { _, _ in
                guard !messages.isEmpty else { return }
                scrollToBottom(proxy: proxy)
            }
        }
    }

    private var emptyState: some View {
        VStack {
            Spacer(minLength: 24)

            EmptyStateView(chips: promptChips, onTap: onPromptTap)
                .padding(.horizontal, 14)

            Spacer(minLength: isCompact ? 18 : 42)
        }
        .frame(maxWidth: .infinity, minHeight: 420)
        .padding(.vertical, 16)
    }

    private var conversationBackground: some View {
        AppTheme.surface.opacity(0.18)
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(.smooth(duration: 0.22)) {
                proxy.scrollTo(ConversationScrollTarget.bottom, anchor: .bottom)
            }
        }
    }
}
