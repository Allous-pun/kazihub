import SwiftUI
import Combine

@MainActor
final class ApplicationsViewModel: ObservableObject {
    @Published var applications: [JobApplication] = MockDataService.applications

    var notificationBadgeCount: Int {
        applications.filter { $0.status == .viewed || $0.status == .accepted }.count + 2
    }

    var pendingCount: Int {
        applications.filter { $0.status == .pending }.count
    }
}
