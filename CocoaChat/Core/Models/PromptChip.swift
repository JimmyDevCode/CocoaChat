import Foundation

struct PromptChip: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let prompt: String
}
