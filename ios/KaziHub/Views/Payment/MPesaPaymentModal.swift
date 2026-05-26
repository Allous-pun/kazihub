import SwiftUI

struct MPesaPaymentModal: View {
    let job: Job
    @EnvironmentObject private var paymentVM: PaymentViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss
    @State private var phoneNumber: String = ""
    @State private var animateContent: Bool = false
    @FocusState private var isPhoneFocused: Bool

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Drag indicator
                RoundedRectangle(cornerRadius: 2.5)
                    .fill(themeManager.textSecondary.opacity(0.3))
                    .frame(width: 36, height: 5)
                    .padding(.top, 12)
                    .padding(.bottom, 20)

                switch paymentVM.status {
                case .idle:
                    paymentForm
                case .processing:
                    processingView
                case .promptSent:
                    promptSentView
                case .completed:
                    successView
                case .failed:
                    failureView
                }
            }
        }
        .interactiveDismissDisabled(paymentVM.status == .processing)
        .onAppear {
            paymentVM.resetPayment()
            paymentVM.currentReceipt = PaymentReceipt(
                amount: job.budget,
                phoneNumber: "",
                jobTitle: job.title
            )
            withAnimation { animateContent = true }
        }
    }

    // MARK: - Payment Form

    private var paymentForm: some View {
        VStack(spacing: 24) {
            // M-Pesa logo area
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 64, height: 64)

                    Text("M")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.green)

                    Text("PESA")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.green)
                        .offset(y: 16)
                }

                Text("M-Pesa Escrow Payment")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                Text("Secure payment held in escrow")
                    .font(.system(size: 13))
                    .foregroundStyle(themeManager.textSecondary)
            }
            .padding(.top, 8)

            // Amount display
            VStack(spacing: 4) {
                Text("Amount to Escrow")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
                Text("\(job.currency) \(job.budget.formatted(.number))")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(ThemeManager.gold)
                Text(job.title)
                    .font(.system(size: 13))
                    .foregroundStyle(themeManager.textSecondary)
                    .lineLimit(1)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background {
                RoundedRectangle(cornerRadius: 14)
                    .fill(themeManager.surface)
            }

            // Phone input
            VStack(alignment: .leading, spacing: 8) {
                Text("M-Pesa Phone Number")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(themeManager.textSecondary)

                HStack(spacing: 8) {
                    Text("+254")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(ThemeManager.gold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(themeManager.surfaceSecondary)
                        }

                    TextField("7XX XXX XXX", text: $phoneNumber)
                        .font(.system(size: 16))
                        .keyboardType(.numberPad)
                        .foregroundStyle(themeManager.textPrimary)
                        .focused($isPhoneFocused)
                }
                .padding(6)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(themeManager.surface)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    isPhoneFocused
                                        ? ThemeManager.gold
                                        : themeManager.textSecondary.opacity(0.15),
                                    lineWidth: 1
                                )
                        }
                }
            }

            // Failure toggle
            HStack {
                Toggle(isOn: $paymentVM.simulateFailure) {
                    Text("Simulate Payment Failure")
                        .font(.system(size: 14))
                        .foregroundStyle(themeManager.textSecondary)
                }
                .tint(.red)
            }
            .padding(.horizontal, 4)

            Spacer(minLength: 20)

            // Pay button
            Button {
                withAnimation(.spring(response: 0.4)) {
                    paymentVM.phoneNumber = phoneNumber
                    paymentVM.initiatePayment(amount: job.budget, jobTitle: job.title)
                }
                Task {
                    await paymentVM.processPayment()
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "iphone.gen3")
                        .font(.system(size: 16))
                    Text("Pay via M-Pesa")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(
                            phoneNumber.count < 9
                                ? themeManager.surfaceSecondary
                                : Color.green
                        )
                }
            }
            .disabled(phoneNumber.count < 9)
            .animation(.easeInOut(duration: 0.2), value: phoneNumber.count)
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Processing

    private var processingView: some View {
        VStack(spacing: 24) {
            Spacer()

            ProgressView()
                .scaleEffect(1.5)
                .tint(Color.green)

            Text("Processing Payment")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            Text("Please wait while we connect to M-Pesa...")
                .font(.system(size: 14))
                .foregroundStyle(themeManager.textSecondary)

            Spacer()
        }
        .padding(20)
    }

    // MARK: - Prompt Sent

    private var promptSentView: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 88, height: 88)

                Image(systemName: "iphone.gen3")
                    .font(.system(size: 36))
                    .foregroundStyle(Color.green)
            }

            VStack(spacing: 6) {
                Text("Check your phone — M-Pesa prompt sent")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                Text("Enter your M-Pesa PIN on\n+254 \(paymentVM.phoneNumber)")
                    .font(.system(size: 14))
                    .foregroundStyle(themeManager.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            ProgressView()
                .tint(Color.green)
                .padding(.top, 8)

            Text("Waiting for confirmation...")
                .font(.system(size: 12))
                .foregroundStyle(themeManager.textSecondary.opacity(0.6))

            Spacer()
        }
        .padding(20)
    }

    // MARK: - Success

    private var successView: some View {
        VStack(spacing: 20) {
            Spacer()

            // Success animation
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 96, height: 96)

                Circle()
                    .stroke(Color.green, lineWidth: 3)
                    .frame(width: 96, height: 96)
                    .scaleEffect(animateContent ? 1 : 0.3)
                    .opacity(animateContent ? 0 : 1)
                    .animation(.easeOut(duration: 0.6), value: animateContent)

                Image(systemName: "checkmark")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Color.green)
                    .scaleEffect(animateContent ? 1 : 0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.2), value: animateContent)
            }
            .onAppear { animateContent = false }
            .task {
                try? await Task.sleep(for: .milliseconds(100))
                withAnimation { animateContent = true }
            }

            VStack(spacing: 4) {
                Text("Escrow Funded Successfully")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                Text("Your payment is now held securely in escrow")
                    .font(.system(size: 14))
                    .foregroundStyle(themeManager.textSecondary)
            }

            // Receipt
            VStack(spacing: 12) {
                HStack {
                    Text("Receipt")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(themeManager.textSecondary)
                    Spacer()
                    Text("M-Pesa Confirmed")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.green)
                }

                Divider()
                    .background(themeManager.textSecondary.opacity(0.1))

                receiptRow(label: "Receipt No.", value: paymentVM.receiptID)
                receiptRow(label: "Amount", value: "\(job.currency) \(job.budget.formatted(.number))")
                receiptRow(label: "Phone", value: "+254 \(paymentVM.phoneNumber)")
                receiptRow(label: "Job", value: job.title)

                Divider()
                    .background(themeManager.textSecondary.opacity(0.1))

                HStack {
                    Text("Total Escrowed")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(themeManager.textPrimary)
                    Spacer()
                    Text("\(job.currency) \(job.budget.formatted(.number))")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(ThemeManager.gold)
                }
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 14)
                    .fill(themeManager.surface)
            }

            Spacer()

            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(ThemeManager.gold)
                    }
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Failure

    private var failureView: some View {
        VStack(spacing: 20) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.1))
                    .frame(width: 96, height: 96)

                Image(systemName: "xmark")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Color.red)
                    .scaleEffect(animateContent ? 1 : 0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.2), value: animateContent)
            }
            .onAppear { animateContent = false }
            .task {
                try? await Task.sleep(for: .milliseconds(100))
                withAnimation { animateContent = true }
            }

            VStack(spacing: 4) {
                Text("Payment failed — insufficient funds")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                Text("Your M-Pesa balance is too low to complete this transaction")
                    .font(.system(size: 14))
                    .foregroundStyle(themeManager.textSecondary)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.red)
                    Text("Possible reasons:")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(themeManager.textPrimary)
                }

                Text("• Insufficient balance")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
                Text("• Daily transaction limit reached")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
                Text("• Incorrect M-Pesa PIN")
                    .font(.system(size: 12))
                    .foregroundStyle(themeManager.textSecondary)
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 14)
                    .fill(themeManager.surface)
            }

            Spacer()

            HStack(spacing: 12) {
                Button {
                    withAnimation {
                        paymentVM.resetPayment()
                    }
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(themeManager.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(themeManager.surface)
                        }
                }

                Button {
                    withAnimation { paymentVM.retryPayment() }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 14))
                        Text("Retry")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.green)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }

    private func receiptRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(themeManager.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(themeManager.textPrimary)
                .lineLimit(1)
        }
    }
}
