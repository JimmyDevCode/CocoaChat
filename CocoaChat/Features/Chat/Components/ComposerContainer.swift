import SwiftUI

struct ComposerContainer: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    let canSend: Bool
    let isGenerating: Bool
    let onSend: () -> Void

    var body: some View {
        ComposerBar(
            text: $text,
            isFocused: $isFocused,
            canSend: canSend,
            isGenerating: isGenerating,
            onSend: onSend
        )
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(
            LinearGradient(
                colors: [
                    AppTheme.background.opacity(0),
                    AppTheme.background.opacity(0.88),
                    AppTheme.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}
