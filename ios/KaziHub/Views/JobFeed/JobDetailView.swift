import SwiftUI

struct JobDetailView: View {
    let job: Job
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var paymentVM: PaymentViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showPaymentModal: Bool = false
    @State private var animateContent: Bool = false

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    heroSection

                    VStack(alignment: .leading, spacing: 24) {
                        budgetRow
                        Divider().background(themeManager.textSecondary.opacity(0.1))
                        detailsSection
                        Divider().background(themeManager.textSecondary.opacity(0.1))
                        skillsSection
                        Divider().background(themeManager.textSecondary.opacity(0.1))
                        descriptionSection
                        Divider().background(themeManager.textSecondary.opacity(0.1))
                        escrowSection
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(themeManager.surface)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Job Details")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(themeManager.textPrimary)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Bookmark action
                } label: {
                    Image(systemName: "bookmark")
                        .foregroundStyle(ThemeManager.gold)
                }
            }
        }
        .sheet(isPresented: $showPaymentModal) {
            MPesaPaymentModal(job: job)
                .environmentObject(paymentVM)
                .environmentObject(themeManager)
                .presentationDetents([.height(500), .large])
                .presentationDragIndicator(.visible)
        }
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 20)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                animateContent = true
            }
        }
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(job.category.rawValue)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(ThemeManager.gold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background {
                        Capsule().fill(ThemeManager.gold.opacity(0.12))
                    }

                if job.isRemote {
                    Text("Remote")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.green)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background {
                            Capsule().fill(Color.green.opacity(0.12))
                        }
                }
            }

            Text(job.title)
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(themeManager.textPrimary)

            HStack(spacing: 8) {
                Circle()
                    .fill(ThemeManager.gold)
                    .frame(width: 36, height: 36)
                    .overlay {
                        Text(String(job.employer.prefix(2)))
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                    }

                VStack(alignment: .leading, spacing: 2) {
                    Text(job.employer)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(themeManager.textPrimary)
                    Text("\(job.postedDate, style: .relative) ago · \(job.duration)")
                        .font(.system(size: 13))
                        .foregroundStyle(themeManager.textSecondary)
                }
            }
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(themeManager.surface)
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .fill(ThemeManager.gold.opacity(0.06))
                        .frame(width: 120, height: 120)
                        .offset(x: 40, y: -40)
                }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var budgetRow: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Monthly Budget")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
                Text("\(job.currency) \(job.budget.formatted(.number))")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(ThemeManager.gold)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Duration")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
                Text(job.duration)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(themeManager.textPrimary)
            }
        }
    }

    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Details")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            detailRow(icon: "mappin.circle.fill", label: "Location", value: job.location)
            detailRow(icon: "clock.fill", label: "Type", value: job.duration)
            detailRow(icon: "wifi", label: "Remote", value: job.isRemote ? "Yes" : "No")
        }
    }

    private func detailRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(ThemeManager.gold)
                .frame(width: 20)

            Text(label)
                .font(.system(size: 14))
                .foregroundStyle(themeManager.textSecondary)
                .frame(width: 70, alignment: .leading)

            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(themeManager.textPrimary)
        }
    }

    private var skillsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Required Skills")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                ForEach(job.skills, id: \.self) { skill in
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 9, weight: .bold))
                        Text(skill)
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundStyle(ThemeManager.gold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(ThemeManager.gold.opacity(0.1))
                    }
                }
            }
        }
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About This Job")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            Text(job.description)
                .font(.system(size: 15))
                .foregroundStyle(themeManager.textSecondary)
                .lineSpacing(4)
        }
    }

    private var escrowSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Secure Payment")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            HStack(spacing: 10) {
                Image(systemName: "shield.checkered")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.green)

                Text("Funds are held in M-Pesa escrow until the job is completed. Your payment is secure.")
                    .font(.system(size: 13))
                    .foregroundStyle(themeManager.textSecondary)
                    .lineSpacing(2)
            }

            Button {
                showPaymentModal = true
            } label: {
                HStack {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 13))
                    Text("Fund Escrow — \(job.currency) \(job.budget.formatted(.number))")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(ThemeManager.gold)
                }
            }
        }
    }
}
