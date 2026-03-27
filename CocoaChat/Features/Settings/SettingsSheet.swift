import SwiftUI

struct SettingsSheet: View {
    @Binding var settings: GenerationSettings
    let modelName: String
    let onReload: () -> Void
    let onClear: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    infoCard
                    temperatureSection
                    tokenSection
                    contextSection
                    toggleSection
                    actionsSection
                }
                .padding(20)
            }
            .background(AppTheme.pageGradient)
            .navigationTitle(String(localized: AppStrings.Settings.title))
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(AppStrings.Settings.localModel)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textSoft)

            Text(modelName)
                .font(.appTitle)
                .foregroundStyle(AppTheme.textPrimary)

            Text(AppStrings.Settings.intro)
                .font(.appBody)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(AppTheme.surface)
        )
    }

    private var temperatureSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(AppStrings.Settings.temperature)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textSoft)

            Text(String(format: "%.1f", settings.temperature))
                .font(.appTitle)
                .foregroundStyle(AppTheme.textPrimary)

            Slider(value: $settings.temperature, in: 0...1.2, step: 0.1)
                .tint(AppTheme.accent)

            Text(AppStrings.Settings.temperatureHelp)
                .font(.appBody)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .cardStyle()
    }

    private var tokenSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(AppStrings.Settings.maxTokens)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textSoft)

            Stepper(value: $settings.maxTokens, in: 32...512, step: 16) {
                Text("\(settings.maxTokens)")
                    .font(.appTitle)
                    .foregroundStyle(AppTheme.textPrimary)
            }

            Text(AppStrings.Settings.maxTokensHelp)
                .font(.appBody)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .cardStyle()
    }

    private var contextSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(AppStrings.Settings.contextLength)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textSoft)

            Stepper(value: $settings.contextLength, in: 512...8192, step: 256) {
                Text("\(settings.contextLength)")
                    .font(.appTitle)
                    .foregroundStyle(AppTheme.textPrimary)
            }

            Text(AppStrings.Settings.contextLengthHelp)
                .font(.appBody)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .cardStyle()
    }

    private var toggleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle(String(localized: AppStrings.Settings.keepContext), isOn: $settings.keepsConversationContext)
                .font(.appBody)
                .foregroundStyle(AppTheme.textPrimary)
                .tint(AppTheme.accent)

            Text(AppStrings.Settings.keepContextHelp)
                .font(.appBody)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .cardStyle()
    }

    private var actionsSection: some View {
        VStack(spacing: 12) {
            Button(String(localized: AppStrings.Settings.reloadModel), action: onReload)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(AppTheme.surfaceStrong)
                )

            Button(String(localized: AppStrings.Settings.clearConversation), role: .destructive, action: onClear)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(AppTheme.warningSoft)
                )
        }
        .font(.appBody)
        .foregroundStyle(AppTheme.textPrimary)
    }
}

private extension View {
    func cardStyle() -> some View {
        padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(AppTheme.surface)
            )
    }
}
