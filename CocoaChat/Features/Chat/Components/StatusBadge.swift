import SwiftUI

struct StatusBadge: View {
    let status: ModelStatus

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 8, height: 8)

            Text(label)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textPrimary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule(style: .continuous)
                .fill(backgroundColor)
        )
    }

    private var label: String {
        switch status {
        case .idle:
            String(localized: AppStrings.Chat.statusIdle)
        case .loading:
            String(localized: AppStrings.Chat.statusLoading)
        case .ready:
            String(localized: AppStrings.Chat.statusReady)
        case .generating:
            String(localized: AppStrings.Chat.statusGenerating)
        case .failed:
            String(localized: AppStrings.Chat.statusError)
        }
    }

    private var indicatorColor: Color {
        switch status {
        case .idle:
            AppTheme.textSoft
        case .loading, .generating:
            AppTheme.accent
        case .ready:
            AppTheme.olive
        case .failed:
            AppTheme.error
        }
    }

    private var backgroundColor: Color {
        switch status {
        case .idle:
            AppTheme.surfaceStrong
        case .loading, .generating:
            AppTheme.warningSoft
        case .ready:
            AppTheme.oliveSoft
        case .failed:
            AppTheme.warningSoft
        }
    }
}
