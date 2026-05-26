import SwiftUI

struct JobCard: View {
    let job: Job
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(job.title)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(themeManager.textPrimary)
                        .lineLimit(1)

                    Text(job.employer)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(ThemeManager.gold)
                }

                Spacer()

                categoryChip
            }

            HStack(spacing: 6) {
                Image(systemName: "banknote")
                    .font(.system(size: 11))
                Text("\(job.currency) \(job.budget.formatted(.number))")
                    .font(.system(size: 15, weight: .bold))
                Text("/mo")
                    .font(.system(size: 12))
                    .opacity(0.5)
            }
            .foregroundStyle(themeManager.textPrimary)

            skillsTags

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 12))
                    Text(job.location)
                        .font(.system(size: 12))
                        .lineLimit(1)
                }
                .foregroundStyle(themeManager.textSecondary)

                if job.isRemote {
                    HStack(spacing: 4) {
                        Image(systemName: "wifi")
                            .font(.system(size: 10))
                        Text("Remote")
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(ThemeManager.gold)
                }

                Spacer()

                Text(job.postedDate, style: .relative)
                    .font(.system(size: 11))
                    .foregroundStyle(themeManager.textSecondary.opacity(0.6))
            }
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(themeManager.surface)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    ThemeManager.gold.opacity(0.12),
                                    themeManager.textSecondary.opacity(0.04)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
        }
        .padding(.horizontal, 16)
    }

    private var categoryChip: some View {
        Text(job.category.rawValue)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(ThemeManager.gold)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background {
                Capsule()
                    .fill(ThemeManager.gold.opacity(0.12))
            }
    }

    private var skillsTags: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(job.skills.prefix(4), id: \.self) { skill in
                    Text(skill)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(themeManager.textSecondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background {
                            Capsule()
                                .fill(themeManager.surfaceSecondary)
                        }
                }

                if job.skills.count > 4 {
                    Text("+\(job.skills.count - 4)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(ThemeManager.gold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background {
                            Capsule()
                                .fill(ThemeManager.gold.opacity(0.1))
                        }
                }
            }
        }
    }
}

