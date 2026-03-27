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
        SettingsCard {
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
        }
    }

    private var temperatureSection: some View {
        SettingsCard {
            SettingsSectionHeader(
                title: AppStrings.Settings.temperature,
                value: String(format: "%.1f", settings.temperature)
            )

            Slider(value: $settings.temperature, in: 0...1.2, step: 0.1)
                .tint(AppTheme.accent)

            SettingsHelpText(AppStrings.Settings.temperatureHelp)
        }
    }

    private var tokenSection: some View {
        SettingsCard {
            SettingsSectionHeader(
                title: AppStrings.Settings.maxTokens,
                value: "\(settings.maxTokens)"
            )

            Stepper(value: $settings.maxTokens, in: 32...512, step: 16) {
                EmptyView()
            }
            .labelsHidden()

            SettingsHelpText(AppStrings.Settings.maxTokensHelp)
        }
    }

    private var contextSection: some View {
        SettingsCard {
            SettingsSectionHeader(
                title: AppStrings.Settings.contextLength,
                value: "\(settings.contextLength)"
            )

            Stepper(value: $settings.contextLength, in: 512...8192, step: 256) {
                EmptyView()
            }
            .labelsHidden()

            SettingsHelpText(AppStrings.Settings.contextLengthHelp)
        }
    }

    private var toggleSection: some View {
        SettingsCard {
            VStack(alignment: .leading, spacing: 12) {
                Toggle(String(localized: AppStrings.Settings.keepContext), isOn: $settings.keepsConversationContext)
                    .font(.appBody)
                    .foregroundStyle(AppTheme.textPrimary)
                    .tint(AppTheme.accent)

                SettingsHelpText(AppStrings.Settings.keepContextHelp)
            }
        }
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

private struct SettingsCard<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            content
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(AppTheme.surface)
        )
    }
}

private struct SettingsSectionHeader: View {
    let title: LocalizedStringResource
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textSoft)

            Text(value)
                .font(.appTitle)
                .foregroundStyle(AppTheme.textPrimary)
        }
    }
}

private struct SettingsHelpText: View {
    let text: LocalizedStringResource

    init(_ text: LocalizedStringResource) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.appBody)
            .foregroundStyle(AppTheme.textSecondary)
    }
}
