import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var viewModel: ProfileViewModel
    @State private var animateContent: Bool = false

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    profileHeader
                    statsRow
                    skillsSection
                    settingsSection
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            animateContent = false
            Task {
                try? await Task.sleep(for: .milliseconds(100))
                withAnimation { animateContent = true }
            }
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [ThemeManager.gold, ThemeManager.goldLight],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)

                Text(viewModel.profile.avatarInitials)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(spacing: 4) {
                Text(viewModel.profile.name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                Text(viewModel.profile.email)
                    .font(.system(size: 14))
                    .foregroundStyle(themeManager.textSecondary)

                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(ThemeManager.gold)
                    Text(String(format: "%.1f", viewModel.profile.rating))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(themeManager.textPrimary)
                    Text("· \(viewModel.profile.completedJobs) jobs completed")
                        .font(.system(size: 13))
                        .foregroundStyle(themeManager.textSecondary)
                }
                .padding(.top, 2)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(themeManager.surface)
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .fill(ThemeManager.gold.opacity(0.05))
                        .frame(width: 150, height: 150)
                        .offset(x: 50, y: -50)
                }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 20)
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            statCard(
                icon: "banknote.fill",
                label: "Total Earnings",
                value: "KSh \(viewModel.profile.totalEarnings.formatted(.number))",
                color: Color.green
            )

            statCard(
                icon: "calendar",
                label: "Member Since",
                value: viewModel.profile.memberSince.formatted(.dateTime.month(.abbreviated).year()),
                color: ThemeManager.gold
            )
        }
        .padding(.horizontal, 16)
    }

    private func statCard(icon: String, label: String, value: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundStyle(color)
                Text(label)
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
            }

            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(themeManager.textPrimary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(themeManager.surface)
        }
    }

    private var skillsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Skills")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(themeManager.textPrimary)

                Spacer()

                Text("\(viewModel.profile.skills.count) skills")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
            }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 8)], spacing: 8) {
                ForEach(viewModel.profile.skills, id: \.self) { skill in
                    HStack(spacing: 5) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 9, weight: .bold))
                        Text(skill)
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundStyle(ThemeManager.gold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 9)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(ThemeManager.gold.opacity(0.08))
                    }
                }
            }
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 18)
                .fill(themeManager.surface)
        }
        .padding(.horizontal, 16)
    }

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Settings")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)

            VStack(spacing: 0) {
                themeToggle

                Divider()
                    .background(themeManager.textSecondary.opacity(0.06))
                    .padding(.leading, 52)

                settingsRow(
                    icon: "bell.fill",
                    label: "Notifications",
                    iconColor: Color.orange
                )

                Divider()
                    .background(themeManager.textSecondary.opacity(0.06))
                    .padding(.leading, 52)

                settingsRow(
                    icon: "lock.fill",
                    label: "Privacy & Security",
                    iconColor: Color.blue
                )

                Divider()
                    .background(themeManager.textSecondary.opacity(0.06))
                    .padding(.leading, 52)

                settingsRow(
                    icon: "questionmark.circle.fill",
                    label: "Help & Support",
                    iconColor: Color.purple
                )

                Divider()
                    .background(themeManager.textSecondary.opacity(0.06))
                    .padding(.leading, 52)

                settingsRow(
                    icon: "info.circle.fill",
                    label: "About KaziHub",
                    iconColor: themeManager.textSecondary
                )
            }
            .background {
                RoundedRectangle(cornerRadius: 18)
                    .fill(themeManager.surface)
            }
            .padding(.horizontal, 16)
        }
    }

    private var themeToggle: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(themeManager.isDarkMode ? ThemeManager.navy700 : Color.orange.opacity(0.15))
                    .frame(width: 32, height: 32)

                Image(systemName: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(themeManager.isDarkMode ? ThemeManager.gold : Color.orange)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("Dark Mode")
                    .font(.system(size: 15))
                    .foregroundStyle(themeManager.textPrimary)

                Text(themeManager.isDarkMode ? "Dark theme active" : "Light theme active")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
            }

            Spacer()

            Toggle("", isOn: $themeManager.isDarkMode)
                .tint(ThemeManager.gold)
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    private func settingsRow(icon: String, label: String, iconColor: Color) -> some View {
        Button {
            // Settings action
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 32, height: 32)

                    Image(systemName: icon)
                        .font(.system(size: 14))
                        .foregroundStyle(iconColor)
                }

                Text(label)
                    .font(.system(size: 15))
                    .foregroundStyle(themeManager.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(themeManager.textSecondary.opacity(0.4))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}
