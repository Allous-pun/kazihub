import SwiftUI
import Combine

@MainActor
final class JobFeedViewModel: ObservableObject {
    @Published var jobs: [Job] = MockDataService.jobs
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var selectedCategory: JobCategory? = nil
    @Published var selectedLocation: String? = nil

    var filteredJobs: [Job] {
        var result = jobs

        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }

        if let location = selectedLocation {
            result = result.filter { $0.location == location }
        }

        if !searchText.isEmpty {
            let query = searchText.lowercased()
            result = result.filter {
                $0.title.lowercased().contains(query) ||
                $0.employer.lowercased().contains(query) ||
                $0.skills.contains { $0.lowercased().contains(query) } ||
                $0.location.lowercased().contains(query)
            }
        }

        return result
    }

    var availableLocations: [String] {
        Array(Set(jobs.map(\.location))).sorted()
    }

    func refreshJobs() async {
        isLoading = true
        try? await Task.sleep(for: .seconds(1.5))
        // Simulate refresh — in real app this would fetch from API
        isLoading = false
    }

    func applyFilters(category: JobCategory?, location: String?) {
        selectedCategory = category
        selectedLocation = location
    }

    func resetFilters() {
        selectedCategory = nil
        selectedLocation = nil
    }

    var hasActiveFilters: Bool {
        selectedCategory != nil || selectedLocation != nil
    }
}
