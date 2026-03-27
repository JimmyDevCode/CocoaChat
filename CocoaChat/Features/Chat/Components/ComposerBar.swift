import SwiftUI
import UIKit

struct ComposerBar: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    let canSend: Bool
    let isGenerating: Bool
    let onSend: () -> Void

    @State private var editorHeight: CGFloat = 44

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(AppStrings.Chat.composerPlaceholder)
                        .font(.appBody)
                        .foregroundStyle(AppTheme.textSoft)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .allowsHitTesting(false)
                }

                GrowingTextEditor(
                    text: $text,
                    dynamicHeight: $editorHeight,
                    isFocused: $isFocused,
                    minHeight: 44,
                    maxHeight: 120,
                    textColor: UIColor(AppTheme.textPrimary),
                    font: UIFont.preferredFont(forTextStyle: .body)
                )
                .frame(height: editorHeight)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = true
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: onSend) {
                Image(systemName: isGenerating ? "hourglass" : "arrow.up")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(width: 42, height: 42)
                    .background(
                        Circle()
                            .fill(canSend ? AppTheme.accent : AppTheme.textSoft)
                    )
            }
            .disabled(!canSend)
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(AppTheme.surface)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(AppTheme.divider, lineWidth: 1)
        }
        .shadow(color: Color.black.opacity(0.05), radius: 18, y: 8)
        .padding(.bottom, 2)
    }
}
