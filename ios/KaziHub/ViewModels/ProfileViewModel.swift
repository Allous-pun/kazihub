import SwiftUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var profile: UserProfile = MockDataService.profile
}
