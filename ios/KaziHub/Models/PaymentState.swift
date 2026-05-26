import Foundation

enum PaymentStatus: String, Codable {
    case idle
    case processing
    case promptSent
    case completed
    case failed
}

struct PaymentReceipt: Identifiable, Codable {
    let id: String
    let amount: Int
    let currency: String
    let phoneNumber: String
    let jobTitle: String
    let timestamp: Date

    init(
        id: String = "",
        amount: Int,
        currency: String = "KSh",
        phoneNumber: String,
        jobTitle: String,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self.phoneNumber = phoneNumber
        self.jobTitle = jobTitle
        self.timestamp = timestamp
    }
}

struct PaymentHistory: Codable {
    var receipts: [PaymentReceipt] = []
    var totalEscrowed: Int = 0
}

struct CurrentPaymentState: Codable {
    var status: PaymentStatus = .idle
    var phoneNumber: String = ""
    var simulateFailure: Bool = false
    var receiptID: String = ""
}
