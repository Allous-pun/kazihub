import Foundation

enum MockDataService {
    static let jobs: [Job] = [
        Job(
            title: "Senior iOS Developer",
            employer: "Safaricom PLC",
            category: .technology,
            budget: 250_000,
            location: "Nairobi, Kenya",
            skills: ["Swift", "SwiftUI", "UIKit", "Core Data", "REST APIs"],
            description: "We're looking for an experienced iOS developer to join our mobile engineering team. You'll be building the next generation of M-Pesa mobile features used by millions of Kenyans. The ideal candidate has strong Swift and SwiftUI experience.",
            isRemote: true,
            duration: "Full-time"
        ),
        Job(
            title: "Financial Analyst",
            employer: "KCB Bank Group",
            category: .finance,
            budget: 180_000,
            location: "Nairobi, Kenya",
            skills: ["Financial Modeling", "Excel", "Data Analysis", "Risk Assessment"],
            description: "Join KCB's corporate finance team to analyze market trends and provide strategic insights for East Africa's largest bank. You'll work on investment strategies and portfolio analysis.",
            duration: "Full-time"
        ),
        Job(
            title: "Registered Nurse",
            employer: "Aga Khan Hospital",
            category: .healthcare,
            budget: 120_000,
            location: "Mombasa, Kenya",
            skills: ["Patient Care", "IV Administration", "Emergency Response", "Medical Records"],
            description: "Aga Khan Hospital Mombasa is seeking dedicated registered nurses to join our growing team. Work in a state-of-the-art facility with international standards of care.",
            duration: "Full-time"
        ),
        Job(
            title: "Secondary School Teacher",
            employer: "Brookhouse Schools",
            category: .education,
            budget: 95_000,
            location: "Nairobi, Kenya",
            skills: ["Mathematics", "Curriculum Development", "Classroom Management", "Assessment"],
            description: "Brookhouse International School seeks a passionate Mathematics teacher for our secondary school program. Cambridge curriculum experience preferred.",
            duration: "Full-time"
        ),
        Job(
            title: "Agronomist Consultant",
            employer: "Twiga Foods",
            category: .agriculture,
            budget: 150_000,
            location: "Thika, Kenya",
            skills: ["Crop Science", "Soil Analysis", "Supply Chain", "Farmer Training"],
            description: "Twiga Foods is revolutionizing agricultural supply chains in Kenya. We need an agronomist to work directly with our network of smallholder farmers to improve crop yields and quality.",
            duration: "Contract"
        ),
        Job(
            title: "Site Engineer",
            employer: "China Road & Bridge Corp",
            category: .construction,
            budget: 200_000,
            location: "Kisumu, Kenya",
            skills: ["Civil Engineering", "AutoCAD", "Project Management", "Structural Analysis"],
            description: "Oversee construction of the new Kisumu bypass project. You'll manage daily site operations, ensure safety compliance, and coordinate with subcontractors.",
            duration: "Contract"
        ),
        Job(
            title: "Hotel Manager",
            employer: "Sarova Hotels",
            category: .hospitality,
            budget: 160_000,
            location: "Nairobi, Kenya",
            skills: ["Hospitality Management", "Staff Training", "Revenue Management", "Guest Relations"],
            description: "Sarova Stanley is looking for an experienced hotel manager to lead our operations. You'll oversee all departments and ensure the highest standards of guest satisfaction.",
            duration: "Full-time"
        ),
        Job(
            title: "Graphic Designer",
            employer: "Ogilvy Africa",
            category: .creative,
            budget: 110_000,
            location: "Nairobi, Kenya",
            skills: ["Adobe Creative Suite", "Figma", "Brand Identity", "Motion Graphics"],
            description: "Create compelling visual content for leading brands across Africa. You'll work on multi-channel campaigns including digital, print, and outdoor advertising.",
            isRemote: true,
            duration: "Full-time"
        ),
        Job(
            title: "Fleet Manager",
            employer: "Sendy Ltd",
            category: .transport,
            budget: 130_000,
            location: "Nairobi, Kenya",
            skills: ["Logistics", "Fleet Maintenance", "Route Optimization", "Team Leadership"],
            description: "Manage Sendy's fleet of delivery vehicles across Nairobi. You'll optimize routes, reduce costs, and ensure timely deliveries for our growing customer base.",
            duration: "Full-time"
        ),
        Job(
            title: "Store Manager",
            employer: "Naivas Supermarket",
            category: .retail,
            budget: 85_000,
            location: "Eldoret, Kenya",
            skills: ["Retail Operations", "Inventory Management", "Customer Service", "Sales Analysis"],
            description: "Lead the day-to-day operations of our newest Naivas branch in Eldoret. You'll manage a team of 30+ staff and drive sales growth in the region.",
            duration: "Full-time"
        ),
        Job(
            title: "Backend Developer",
            employer: "Cellulant Corporation",
            category: .technology,
            budget: 220_000,
            location: "Nairobi, Kenya",
            skills: ["Node.js", "PostgreSQL", "AWS", "Microservices", "Docker"],
            description: "Build the payments infrastructure powering digital commerce across Africa. You'll work on high-scale systems processing millions of transactions daily.",
            isRemote: true,
            duration: "Full-time"
        ),
        Job(
            title: "Accountant",
            employer: "PwC Kenya",
            category: .finance,
            budget: 140_000,
            location: "Nairobi, Kenya",
            skills: ["CPA(K)", "IFRS", "Audit", "Taxation", "QuickBooks"],
            description: "Join PwC's audit and assurance team in Nairobi. You'll work with diverse clients across East Africa, from startups to multinational corporations.",
            duration: "Full-time"
        ),
        Job(
            title: "Lab Technologist",
            employer: "Kenyatta National Hospital",
            category: .healthcare,
            budget: 90_000,
            location: "Nairobi, Kenya",
            skills: ["Lab Diagnostics", "Equipment Maintenance", "Sample Analysis", "Quality Control"],
            description: "KNH is seeking a qualified lab technologist to join our pathology department. You'll perform diagnostic tests and maintain laboratory equipment.",
            duration: "Full-time"
        ),
        Job(
            title: "UX Researcher",
            employer: "Andela",
            category: .technology,
            budget: 190_000,
            location: "Nairobi, Kenya",
            skills: ["User Research", "Usability Testing", "Data Analysis", "Figma", "Prototyping"],
            description: "Andela is building world-class engineering teams. We need a UX researcher to help us understand user needs and improve our talent marketplace platform.",
            isRemote: true,
            duration: "Full-time"
        ),
        Job(
            title: "Farm Operations Lead",
            employer: "Kakuzi PLC",
            category: .agriculture,
            budget: 175_000,
            location: "Thika, Kenya",
            skills: ["Farm Management", "Irrigation Systems", "Harvest Planning", "Quality Standards"],
            description: "Kakuzi is a leading agricultural company. We're looking for a farm operations lead to manage our macadamia and avocado operations across 2,000+ hectares.",
            duration: "Full-time"
        )
    ]

    static let applications: [JobApplication] = [
        JobApplication(
            job: jobs[0],
            status: .accepted,
            coverLetter: "With 7 years of iOS development experience and having built apps serving millions of users, I am confident I can deliver exceptional value to the Safaricom mobile team.",
            proposedRate: 240_000
        ),
        JobApplication(
            job: jobs[2],
            status: .pending,
            coverLetter: "I have 5 years of nursing experience in busy hospital environments and am passionate about providing quality patient care.",
            proposedRate: 115_000
        ),
        JobApplication(
            job: jobs[3],
            status: .viewed,
            coverLetter: "As a Cambridge-certified Mathematics teacher with 8 years of experience, I can bring strong curriculum expertise to Brookhouse Schools.",
            proposedRate: 90_000
        ),
        JobApplication(
            job: jobs[7],
            status: .rejected,
            coverLetter: "I have extensive experience in brand design and have worked with top agencies across East Africa.",
            proposedRate: 105_000
        )
    ]

    static let conversations: [Conversation] = [
        Conversation(
            contactName: "Safaricom HR",
            lastMessage: "Great, we'd like to schedule an interview for next week. Does Tuesday work for you?",
            lastMessageDate: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(),
            messages: [
                ChatMessage(text: "Hello! Thank you for applying to the Senior iOS Developer position.", isFromMe: false, timestamp: Date().addingTimeInterval(-86400)),
                ChatMessage(text: "Hi! Thanks for reaching out. I'm very interested in the role.", isFromMe: true, timestamp: Date().addingTimeInterval(-86000)),
                ChatMessage(text: "Your portfolio looks impressive. We'd love to learn more about your experience with large-scale apps.", isFromMe: false, timestamp: Date().addingTimeInterval(-80000)),
                ChatMessage(text: "I've worked on apps with 5M+ users at my previous role. I can share specific examples.", isFromMe: true, timestamp: Date().addingTimeInterval(-76000)),
                ChatMessage(text: "Great, we'd like to schedule an interview for next week. Does Tuesday work for you?", isFromMe: false, timestamp: Date().addingTimeInterval(-7200)),
            ],
            unreadCount: 2
        ),
        Conversation(
            contactName: "KCB Bank HR",
            lastMessage: "Please submit your CPA(K) certificate when you have a moment.",
            lastMessageDate: Calendar.current.date(byAdding: .hour, value: -24, to: Date()) ?? Date(),
            messages: [
                ChatMessage(text: "We've received your application for the Accountant position.", isFromMe: false, timestamp: Date().addingTimeInterval(-172800)),
                ChatMessage(text: "Thank you for the update! Is there any additional information you need?", isFromMe: true, timestamp: Date().addingTimeInterval(-170000)),
                ChatMessage(text: "Please submit your CPA(K) certificate when you have a moment.", isFromMe: false, timestamp: Date().addingTimeInterval(-86400)),
            ],
            unreadCount: 0
        ),
        Conversation(
            contactName: "Andela Talent Team",
            lastMessage: "Looking forward to seeing your portfolio presentation.",
            lastMessageDate: Calendar.current.date(byAdding: .hour, value: -48, to: Date()) ?? Date(),
            messages: [
                ChatMessage(text: "Hi! We loved your UX Researcher application.", isFromMe: false, timestamp: Date().addingTimeInterval(-259200)),
                ChatMessage(text: "That's amazing to hear! I'm really excited about Andela's mission.", isFromMe: true, timestamp: Date().addingTimeInterval(-258000)),
                ChatMessage(text: "Can you prepare a short portfolio presentation for our team?", isFromMe: false, timestamp: Date().addingTimeInterval(-250000)),
                ChatMessage(text: "Absolutely! I'll put together my best case studies and share them.", isFromMe: true, timestamp: Date().addingTimeInterval(-240000)),
                ChatMessage(text: "Looking forward to seeing your portfolio presentation.", isFromMe: false, timestamp: Date().addingTimeInterval(-172800)),
            ],
            unreadCount: 0
        )
    ]

    static let profile = UserProfile()

    static func generateReceiptID() -> String {
        "NLJ7RT61SV"
    }
}
