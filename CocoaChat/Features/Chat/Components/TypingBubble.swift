import SwiftUI

struct TypingBubble: View {
    @State private var phase = false

    var body: some View {
        HStack {
            HStack(spacing: 6) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(AppTheme.accent.opacity(phase ? 0.35 : 0.9))
                        .frame(width: 8, height: 8)
                        .animation(
                            .easeInOut(duration: 0.7)
                                .repeatForever()
                                .delay(Double(index) * 0.12),
                            value: phase
                        )
                }

                Text(AppStrings.Chat.typing)
                    .font(.appCaption)
                    .foregroundStyle(AppTheme.textSecondary)
                    .padding(.leading, 4)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(AppTheme.modelBubble)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(AppTheme.modelBorder, lineWidth: 1)
            }

            Spacer(minLength: 56)
        }
        .task {
            phase.toggle()
        }
    }
}
