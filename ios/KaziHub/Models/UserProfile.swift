import Foundation

struct UserProfile: Codable {
    var name: String
    var email: String
    var skills: [String]
    var totalEarnings: Int
    var completedJobs: Int
    var memberSince: Date
    var avatarInitials: String
    var rating: Double
    var location: String

    init(
        name: String = "John Mwangi",
        email: String = "john.mwangi@email.com",
        skills: [String] = ["iOS Development", "Swift", "UI/UX Design", "React Native", "Firebase"],
        totalEarnings: Int = 450_000,
        completedJobs: Int = 23,
        memberSince: Date = Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 15)) ?? Date(),
        avatarInitials: String = "JM",
        rating: Double = 4.8,
        location: String = "Nairobi, Kenya"
    ) {
        self.name = name
        self.email = email
        self.skills = skills
        self.totalEarnings = totalEarnings
        self.completedJobs = completedJobs
        self.memberSince = memberSince
        self.avatarInitials = avatarInitials
        self.rating = rating
        self.location = location
    }
}
