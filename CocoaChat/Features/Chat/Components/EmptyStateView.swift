import SwiftUI

struct EmptyStateView: View {
    let chips: [PromptChip]
    let onTap: (PromptChip) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            VStack(alignment: .leading, spacing: 10) {
                Text(AppStrings.Chat.emptyTitle)
                    .font(.appLargeTitle)
                    .foregroundStyle(AppTheme.textPrimary)

                Text(AppStrings.Chat.emptyBody)
                    .font(.appBody)
                    .foregroundStyle(AppTheme.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            VStack(spacing: 10) {
                ForEach(chips) { chip in
                    Button {
                        onTap(chip)
                    } label: {
                        HStack {
                            Text(chip.title)
                                .font(.appBody)
                                .foregroundStyle(AppTheme.textPrimary)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(AppTheme.textSoft)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(AppTheme.surface)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(AppTheme.divider, lineWidth: 1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }

            Text(AppStrings.Chat.emptyFootnote)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textSoft)
        }
        .frame(maxWidth: 560, alignment: .leading)
        .padding(18)
    }
}
