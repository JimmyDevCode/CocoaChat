import CocoaLM
import Foundation
import Observation

@MainActor
@Observable
final class ChatViewModel {
    var messages: [ChatMessage] = []
    var draft = ""
    var status: ModelStatus = .idle
    var settings = GenerationSettings()
    var isShowingSettings = false

    private let service = CocoaLMService()
    private var session: CocoaLMSession?

    var modelName: String {
        service.modelDisplayName()
    }

    let promptChips: [PromptChip] = [
        .init(title: String(localized: AppStrings.Chat.chipSummarizeTitle), prompt: String(localized: AppStrings.Chat.chipSummarizePrompt)),
        .init(title: String(localized: AppStrings.Chat.chipRewriteTitle), prompt: String(localized: AppStrings.Chat.chipRewritePrompt)),
        .init(title: String(localized: AppStrings.Chat.chipExplainTitle), prompt: String(localized: AppStrings.Chat.chipExplainPrompt)),
        .init(title: String(localized: AppStrings.Chat.chipBrainstormTitle), prompt: String(localized: AppStrings.Chat.chipBrainstormPrompt))
    ]

    var canSend: Bool {
        !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isGenerating
    }

    var isGenerating: Bool {
        if case .generating = status {
            return true
        }
        return false
    }

    func applyChip(_ chip: PromptChip) {
        draft = chip.prompt
    }

    func clearConversation() {
        messages.removeAll()
    }

    func reloadModel() async {
        status = .loading

        do {
            session = try service.loadSession(settings: settings)
            status = .ready
        } catch {
            session = nil
            status = .failed(error.localizedDescription)
        }
    }

    func send() async {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, !isGenerating else { return }

        if session == nil {
            await reloadModel()
        }

        guard let activeSession = session else { return }

        let keepsContext = settings.keepsConversationContext
        draft = ""
        messages.append(ChatMessage(role: .user, text: text, createdAt: .now))
        status = .generating

        let history = Array(messages.dropLast().suffix(keepsContext ? 8 : 0))

        do {
            let reply = try await service.generate(
                session: activeSession,
                messages: history,
                latestUserPrompt: text,
                keepsConversationContext: keepsContext
            )
            messages.append(ChatMessage(role: .assistant, text: reply, createdAt: .now))
            status = .ready
        } catch {
            status = .failed(error.localizedDescription)
            messages.append(
                ChatMessage(
                    role: .assistant,
                    text: String(localized: AppStrings.Chat.generationFailed),
                    createdAt: .now
                )
            )
        }
    }
}
