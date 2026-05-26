import SwiftUI
import Combine

@MainActor
final class PaymentViewModel: ObservableObject {
    @Published var status: PaymentStatus = .idle {
        didSet { persistCurrentState() }
    }
    @Published var phoneNumber: String = "" {
        didSet { persistCurrentState() }
    }
    @Published var simulateFailure: Bool = false {
        didSet { persistCurrentState() }
    }
    @Published var receiptID: String = "" {
        didSet { persistCurrentState() }
    }
    @Published var currentReceipt: PaymentReceipt? = nil
    @Published var paymentHistory: PaymentHistory = PaymentHistory()

    private let storageKey = "kaziHub_paymentHistory"
    private let currentStateKey = "kaziHub_currentPaymentState"

    init() {
        loadHistory()
        loadCurrentState()
    }

    func initiatePayment(amount: Int, jobTitle: String) {
        status = .processing
    }

    func processPayment() async {
        status = .processing
        try? await Task.sleep(for: .seconds(2))

        if simulateFailure {
            status = .failed
            return
        }

        status = .promptSent
        try? await Task.sleep(for: .seconds(3))

        status = .completed
        let receipt = PaymentReceipt(
            id: MockDataService.generateReceiptID(),
            amount: currentReceipt?.amount ?? 0,
            phoneNumber: phoneNumber,
            jobTitle: currentReceipt?.jobTitle ?? ""
        )
        receiptID = receipt.id
        currentReceipt = receipt
        paymentHistory.receipts.append(receipt)
        paymentHistory.totalEscrowed += receipt.amount
        saveHistory()
    }

    func retryPayment() {
        status = .idle
        simulateFailure = false
    }

    func resetPayment() {
        status = .idle
        phoneNumber = ""
        simulateFailure = false
        receiptID = ""
        currentReceipt = nil
    }

    /// Restore a pending payment from saved state — used when app relaunches mid-flow
    func restorePendingPayment() {
        let savedState = loadCurrentState()
        guard savedState.status != .idle else { return }
        status = savedState.status
        phoneNumber = savedState.phoneNumber
        simulateFailure = savedState.simulateFailure
        receiptID = savedState.receiptID
    }

    // MARK: - Persistence

    private func saveHistory() {
        if let data = try? JSONEncoder().encode(paymentHistory) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let history = try? JSONDecoder().decode(PaymentHistory.self, from: data) else { return }
        paymentHistory = history
    }

    private func persistCurrentState() {
        let state = CurrentPaymentState(
            status: status,
            phoneNumber: phoneNumber,
            simulateFailure: simulateFailure,
            receiptID: receiptID
        )
        if let data = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(data, forKey: currentStateKey)
        }
    }

    @discardableResult
    private func loadCurrentState() -> CurrentPaymentState {
        guard let data = UserDefaults.standard.data(forKey: currentStateKey),
              let state = try? JSONDecoder().decode(CurrentPaymentState.self, from: data) else {
            return CurrentPaymentState()
        }
        return state
    }
}
