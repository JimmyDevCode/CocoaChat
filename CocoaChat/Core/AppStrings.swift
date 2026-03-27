import Foundation

enum AppStrings {
    enum Chat {
        static let title: LocalizedStringResource = "chat.title"
        static let subtitle: LocalizedStringResource = "chat.subtitle"
        static let statusIdle: LocalizedStringResource = "chat.status.idle"
        static let statusLoading: LocalizedStringResource = "chat.status.loading"
        static let statusReady: LocalizedStringResource = "chat.status.ready"
        static let statusGenerating: LocalizedStringResource = "chat.status.generating"
        static let statusError: LocalizedStringResource = "chat.status.error"
        static let localStatusFormat: LocalizedStringResource = "chat.status.local_format"

        static let emptyTitle: LocalizedStringResource = "chat.empty.title"
        static let emptyBody: LocalizedStringResource = "chat.empty.body"
        static let emptyFootnote: LocalizedStringResource = "chat.empty.footnote"

        static let composerPlaceholder: LocalizedStringResource = "chat.composer.placeholder"
        static let typing: LocalizedStringResource = "chat.typing"
        static let keyboardDone: LocalizedStringResource = "chat.keyboard.done"
        static let generationFailed: LocalizedStringResource = "chat.generation.failed"

        static let chipSummarizeTitle: LocalizedStringResource = "chat.chip.summarize.title"
        static let chipSummarizePrompt: LocalizedStringResource = "chat.chip.summarize.prompt"
        static let chipRewriteTitle: LocalizedStringResource = "chat.chip.rewrite.title"
        static let chipRewritePrompt: LocalizedStringResource = "chat.chip.rewrite.prompt"
        static let chipExplainTitle: LocalizedStringResource = "chat.chip.explain.title"
        static let chipExplainPrompt: LocalizedStringResource = "chat.chip.explain.prompt"
        static let chipBrainstormTitle: LocalizedStringResource = "chat.chip.brainstorm.title"
        static let chipBrainstormPrompt: LocalizedStringResource = "chat.chip.brainstorm.prompt"
    }

    enum Settings {
        static let title: LocalizedStringResource = "settings.title"
        static let localModel: LocalizedStringResource = "settings.local_model"
        static let intro: LocalizedStringResource = "settings.intro"
        static let temperature: LocalizedStringResource = "settings.temperature"
        static let temperatureHelp: LocalizedStringResource = "settings.temperature.help"
        static let maxTokens: LocalizedStringResource = "settings.max_tokens"
        static let maxTokensHelp: LocalizedStringResource = "settings.max_tokens.help"
        static let contextLength: LocalizedStringResource = "settings.context_length"
        static let contextLengthHelp: LocalizedStringResource = "settings.context_length.help"
        static let keepContext: LocalizedStringResource = "settings.keep_context"
        static let keepContextHelp: LocalizedStringResource = "settings.keep_context.help"
        static let reloadModel: LocalizedStringResource = "settings.reload_model"
        static let clearConversation: LocalizedStringResource = "settings.clear_conversation"
    }
}
