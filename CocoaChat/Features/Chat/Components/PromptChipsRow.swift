import SwiftUI

struct PromptChipsRow: View {
    let chips: [PromptChip]
    let onTap: (PromptChip) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(chips) { chip in
                    Button(chip.title) {
                        onTap(chip)
                    }
                    .font(.appCaption)
                    .foregroundStyle(AppTheme.textPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        Capsule(style: .continuous)
                            .fill(AppTheme.surface)
                    )
                    .overlay {
                        Capsule(style: .continuous)
                            .stroke(AppTheme.divider, lineWidth: 1)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 2)
        }
    }
}
