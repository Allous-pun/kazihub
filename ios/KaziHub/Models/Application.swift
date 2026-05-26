import Foundation

struct JobApplication: Identifiable, Codable, Hashable {
    let id: UUID
    let job: Job
    let status: ApplicationStatus
    let appliedDate: Date
    let coverLetter: String
    let proposedRate: Int

    init(
        id: UUID = UUID(),
        job: Job,
        status: ApplicationStatus = .pending,
        appliedDate: Date = Date(),
        coverLetter: String = "",
        proposedRate: Int = 0
    ) {
        self.id = id
        self.job = job
        self.status = status
        self.appliedDate = appliedDate
        self.coverLetter = coverLetter
        self.proposedRate = proposedRate
    }
}

enum ApplicationStatus: String, CaseIterable, Codable, Hashable {
    case pending = "Pending"
    case viewed = "Viewed"
    case accepted = "Accepted"
    case rejected = "Rejected"

    var color: String {
        switch self {
        case .pending: return "pendingColor"
        case .viewed: return "viewedColor"
        case .accepted: return "acceptedColor"
        case .rejected: return "rejectedColor"
        }
    }

    var icon: String {
        switch self {
        case .pending: return "clock.fill"
        case .viewed: return "eye.fill"
        case .accepted: return "checkmark.circle.fill"
        case .rejected: return "xmark.circle.fill"
        }
    }
}
