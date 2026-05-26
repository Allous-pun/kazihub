import SwiftUI

struct MyApplicationsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var viewModel: ApplicationsViewModel
    @State private var animateCards: Bool = false

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            VStack(spacing: 0) {
                headerSection

                if viewModel.applications.isEmpty {
                    emptyState
                } else {
                    applicationsList
                }
            }
        }
        .onAppear {
            animateCards = false
            Task {
                try? await Task.sleep(for: .milliseconds(100))
                withAnimation { animateCards = true }
            }
        }
    }

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("My Applications")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                Text("\(viewModel.applications.count) proposals submitted")
                    .font(.system(size: 14))
                    .foregroundStyle(themeManager.textSecondary)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }

    private var applicationsList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(Array(viewModel.applications.enumerated()), id: \.element.id) { index, application in
                    ApplicationCard(application: application)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(
                            .spring(response: 0.4, dampingFraction: 0.8).delay(Double(index) * 0.08),
                            value: animateCards
                        )
                }
            }
            .padding(.vertical, 4)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(themeManager.textSecondary.opacity(0.4))

            Text("No Applications Yet")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            Text("Start applying to jobs and track your proposals here")
                .font(.system(size: 14))
                .foregroundStyle(themeManager.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 40)
    }
}

struct ApplicationCard: View {
    let application: JobApplication
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(application.job.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(themeManager.textPrimary)
                        .lineLimit(1)

                    Text(application.job.employer)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(ThemeManager.gold)
                }

                Spacer()

                statusBadge
            }

            if !application.coverLetter.isEmpty {
                Text(application.coverLetter)
                    .font(.system(size: 13))
                    .foregroundStyle(themeManager.textSecondary)
                    .lineLimit(2)
                    .lineSpacing(3)
            }

            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "banknote")
                        .font(.system(size: 11))
                    Text("KSh \(application.proposedRate.formatted(.number))")
                        .font(.system(size: 13, weight: .medium))
                }
                .foregroundStyle(themeManager.textSecondary)

                Spacer()

                Text("Applied \(application.appliedDate, style: .relative) ago")
                    .font(.system(size: 11))
                    .foregroundStyle(themeManager.textSecondary.opacity(0.6))
            }
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(themeManager.surface)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(statusColor.opacity(0.06))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(themeManager.textSecondary.opacity(0.08), lineWidth: 1)
                }
        }
        .padding(.horizontal, 16)
    }

    private var statusBadge: some View {
        HStack(spacing: 5) {
            Image(systemName: application.status.icon)
                .font(.system(size: 10, weight: .bold))
            Text(application.status.rawValue)
                .font(.system(size: 11, weight: .bold))
        }
        .foregroundStyle(statusColor)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background {
            Capsule()
                .fill(statusColor.opacity(0.12))
        }
    }

    private var statusColor: Color {
        switch application.status {
        case .pending: return ThemeManager.pendingColor
        case .viewed: return ThemeManager.viewedColor
        case .accepted: return ThemeManager.acceptedColor
        case .rejected: return ThemeManager.rejectedColor
        }
    }
}
