import Observation
import SwiftUI

struct ChatScreen: View {
    @State private var viewModel: ChatViewModel
    @FocusState private var isComposerFocused: Bool

    private var isCompactMode: Bool {
        viewModel.isGenerating
    }

    init(viewModel: ChatViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        @Bindable var bindableViewModel = viewModel

        ZStack {
            AppTheme.pageGradient
                .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])

            VStack(spacing: isCompactMode ? 12 : 18) {
                ChatHeader(
                    status: viewModel.status,
                    isCompact: isCompactMode,
                    onSettingsTap: {
                        viewModel.isShowingSettings = true
                    }
                )

                ConversationPane(
                    messages: viewModel.messages,
                    promptChips: viewModel.promptChips,
                    isGenerating: viewModel.isGenerating,
                    isCompact: isCompactMode,
                    onPromptTap: { chip in
                        viewModel.applyChip(chip)
                        isComposerFocused = true
                    },
                    onBackgroundTap: {
                        dismissKeyboard()
                    }
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, isCompactMode ? 10 : 18)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            ComposerContainer(
                text: $bindableViewModel.draft,
                isFocused: $isComposerFocused,
                canSend: viewModel.canSend,
                isGenerating: viewModel.isGenerating
            ) {
                Task {
                    await viewModel.send()
                }
            }
        }
        .sheet(isPresented: $bindableViewModel.isShowingSettings) {
            SettingsSheet(
                settings: $bindableViewModel.settings,
                modelName: viewModel.modelName,
                onReload: {
                    Task {
                        await viewModel.reloadModel()
                    }
                },
                onClear: {
                    viewModel.clearConversation()
                }
            )
            .presentationDetents([.medium, .large])
        }
        .task {
            if case .idle = viewModel.status {
                await viewModel.reloadModel()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button(String(localized: AppStrings.Chat.keyboardDone)) {
                    dismissKeyboard()
                }
            }
        }
    }

    private func dismissKeyboard() {
        isComposerFocused = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ChatScreen(
        viewModel: ChatViewModel(service: CocoaLMChatService())
    )
}
