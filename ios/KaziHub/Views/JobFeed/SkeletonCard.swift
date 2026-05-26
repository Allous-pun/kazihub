import SwiftUI

struct SkeletonCard: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(themeManager.surfaceSecondary)
                    .frame(width: 140, height: 18)
                    .shimmer()

                Spacer()

                RoundedRectangle(cornerRadius: 4)
                    .fill(themeManager.surfaceSecondary)
                    .frame(width: 80, height: 24)
                    .shimmer()
            }

            RoundedRectangle(cornerRadius: 6)
                .fill(themeManager.surfaceSecondary)
                .frame(width: 100, height: 14)
                .shimmer()

            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(themeManager.surfaceSecondary)
                    .frame(width: 60, height: 22)
                    .shimmer()
                RoundedRectangle(cornerRadius: 4)
                    .fill(themeManager.surfaceSecondary)
                    .frame(width: 80, height: 22)
                    .shimmer()
                RoundedRectangle(cornerRadius: 4)
                    .fill(themeManager.surfaceSecondary)
                    .frame(width: 70, height: 22)
                    .shimmer()
            }

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(themeManager.surfaceSecondary)
                        .frame(width: 14, height: 14)
                        .shimmer()
                    RoundedRectangle(cornerRadius: 4)
                        .fill(themeManager.surfaceSecondary)
                        .frame(width: 80, height: 12)
                        .shimmer()
                }

                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(themeManager.surfaceSecondary)
                        .frame(width: 14, height: 14)
                        .shimmer()
                    RoundedRectangle(cornerRadius: 4)
                        .fill(themeManager.surfaceSecondary)
                        .frame(width: 100, height: 12)
                        .shimmer()
                }
            }
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(themeManager.surface)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(themeManager.textSecondary.opacity(0.08), lineWidth: 1)
                }
        }
        .padding(.horizontal, 16)
    }
}

extension View {
    func shimmer() -> some View {
        self
            .opacity(0.4)
            .overlay {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: geo.size.height / 2)
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0),
                                    .white.opacity(0.08),
                                    .white.opacity(0),
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .offset(x: -geo.size.width)
                }
            }
    }
}
