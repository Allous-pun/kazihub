import Foundation

struct Job: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let employer: String
    let category: JobCategory
    let budget: Int
    let currency: String
    let location: String
    let skills: [String]
    let description: String
    let postedDate: Date
    let isRemote: Bool
    let duration: String

    init(
        id: UUID = UUID(),
        title: String,
        employer: String,
        category: JobCategory,
        budget: Int,
        currency: String = "KSh",
        location: String,
        skills: [String],
        description: String,
        postedDate: Date = Date(),
        isRemote: Bool = false,
        duration: String = "Full-time"
    ) {
        self.id = id
        self.title = title
        self.employer = employer
        self.category = category
        self.budget = budget
        self.currency = currency
        self.location = location
        self.skills = skills
        self.description = description
        self.postedDate = postedDate
        self.isRemote = isRemote
        self.duration = duration
    }
}

enum JobCategory: String, CaseIterable, Codable, Hashable {
    case technology = "Technology"
    case finance = "Finance"
    case healthcare = "Healthcare"
    case education = "Education"
    case agriculture = "Agriculture"
    case construction = "Construction"
    case hospitality = "Hospitality"
    case creative = "Creative"
    case transport = "Transport"
    case retail = "Retail"
}
