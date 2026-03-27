import SwiftUI

struct ChatHeader: View {
    let status: ModelStatus
    let modelName: String
    let isCompact: Bool
    let onSettingsTap: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(AppStrings.Chat.title)
                    .font(isCompact ? .appTitle : .appLargeTitle)
                    .foregroundStyle(AppTheme.textPrimary)

                Text(statusLine)
                    .font(.appCaption)
                    .foregroundStyle(AppTheme.textSecondary)
            }

            Spacer(minLength: 0)

            Button(action: onSettingsTap) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppTheme.textPrimary)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(AppTheme.surface)
                    )
            }
            .buttonStyle(.plain)
        }
    }

    private var statusLine: String {
        let state: String = switch status {
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

        return String(format: String(localized: AppStrings.Chat.localStatusFormat), state)
    }
}
