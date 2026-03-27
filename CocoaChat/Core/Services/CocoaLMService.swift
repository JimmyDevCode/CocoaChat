import CocoaLM
import Foundation

protocol ChatSessioning: AnyObject {
    func generate(userPrompt: String, systemPrompt: String) async throws -> String
}

protocol ChatInferenceServicing {
    var modelDisplayName: String { get }
    func makeSession(settings: GenerationSettings) throws -> any ChatSessioning
    func generateReply(
        session: any ChatSessioning,
        messages: [ChatMessage],
        latestUserPrompt: String,
        keepsConversationContext: Bool
    ) async throws -> String
}

final class CocoaLMChatSession: ChatSessioning {
    private let session: CocoaLMSession

    init(session: CocoaLMSession) {
        self.session = session
    }

    func generate(userPrompt: String, systemPrompt: String) async throws -> String {
        try await session.generate(
            userPrompt: userPrompt,
            systemPrompt: systemPrompt
        )
    }
}

struct CocoaLMChatService: ChatInferenceServicing {
    private let model = ModelCatalog.qwen15BInstructQ4

    var modelDisplayName: String {
        model.displayName
    }

    func makeSession(settings: GenerationSettings) throws -> any ChatSessioning {
        let session = try CocoaLMSession(
            model: model,
            strategy: .bundleThenDocuments,
            generationConfig: GenerationConfig(
                contextLength: settings.contextLength,
                maxTokens: settings.maxTokens,
                temperature: settings.temperature
            )
        )

        return CocoaLMChatSession(session: session)
    }

    func generateReply(
        session: any ChatSessioning,
        messages: [ChatMessage],
        latestUserPrompt: String,
        keepsConversationContext: Bool
    ) async throws -> String {
        let prompt = promptBody(
            messages: messages,
            latestUserPrompt: latestUserPrompt,
            keepsConversationContext: keepsConversationContext
        )

        return try await session.generate(
            userPrompt: prompt,
            systemPrompt: systemPrompt
        )
    }

    private var systemPrompt: String {
        """
        You are a concise assistant inside a SwiftUI app called CocoaChat.
        Write clean, natural English.
        Keep answers short and readable.
        Do not use markdown unless the user asks for it.
        Do not output symbols, code, or numbered noise unless the user explicitly asks for them.
        """
    }

    private func promptBody(
        messages: [ChatMessage],
        latestUserPrompt: String,
        keepsConversationContext: Bool
    ) -> String {
        guard keepsConversationContext else {
            return """
            Reply to the following user request in one clear answer.

            User request:
            \(latestUserPrompt)
            """
        }

        let history = messages
            .suffix(6)
            .map { message in
                let role = message.role == .user ? "User" : "Assistant"
                return "\(role): \(message.text)"
            }
            .joined(separator: "\n")

        if history.isEmpty {
            return latestUserPrompt
        }

        return """
        Continue this conversation naturally.
        Keep the answer short, clear, and free of random symbols.

        \(history)
        User: \(latestUserPrompt)
        Assistant:
        """
    }
}
