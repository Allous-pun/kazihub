import SwiftUI

struct JobFeedView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var viewModel: JobFeedViewModel
    @EnvironmentObject private var paymentVM: PaymentViewModel
    @Binding var navigationPath: NavigationPath
    @State private var showFilterSheet: Bool = false
    @State private var showSkeleton: Bool = true

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            VStack(spacing: 0) {
                headerSection
                searchBar
                filterIndicator

                if showSkeleton {
                    skeletonList
                } else if viewModel.filteredJobs.isEmpty {
                    emptyState
                } else {
                    jobsList
                }
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(1.2))
            withAnimation { showSkeleton = false }
        }
        .sheet(isPresented: $showFilterSheet) {
            FilterSheet()
                .environmentObject(viewModel)
                .environmentObject(themeManager)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Find Work")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(themeManager.textPrimary)

                Text("\(viewModel.jobs.count) jobs available")
                    .font(.system(size: 14))
                    .foregroundStyle(themeManager.textSecondary)
            }

            Spacer()

            Button {
                withAnimation { showFilterSheet = true }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(themeManager.surface)
                        .frame(width: 44, height: 44)
                        .overlay {
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(themeManager.textSecondary.opacity(0.1), lineWidth: 1)
                        }

                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(
                            viewModel.hasActiveFilters
                                ? ThemeManager.gold
                                : themeManager.textSecondary
                        )
                }
                .overlay(alignment: .topTrailing) {
                    if viewModel.hasActiveFilters {
                        Circle()
                            .fill(ThemeManager.gold)
                            .frame(width: 8, height: 8)
                            .offset(x: 6, y: -4)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundStyle(themeManager.textSecondary)

            TextField("Search jobs, skills, employers...", text: $viewModel.searchText)
                .font(.system(size: 16))
                .foregroundStyle(themeManager.textPrimary)

            if !viewModel.searchText.isEmpty {
                Button {
                    withAnimation { viewModel.searchText = "" }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(themeManager.textSecondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .fill(themeManager.surface)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }

    @ViewBuilder
    private var filterIndicator: some View {
        if viewModel.hasActiveFilters {
            HStack(spacing: 8) {
                if let category = viewModel.selectedCategory {
                    FilterChip(
                        label: category.rawValue,
                        onRemove: { viewModel.selectedCategory = nil }
                    )
                }
                if let location = viewModel.selectedLocation {
                    FilterChip(
                        label: location,
                        onRemove: { viewModel.selectedLocation = nil }
                    )
                }

                Button("Clear All") {
                    withAnimation { viewModel.resetFilters() }
                }
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(ThemeManager.gold)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
    }

    private var skeletonList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(0..<6, id: \.self) { _ in
                    SkeletonCard()
                }
            }
            .padding(.vertical, 8)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(themeManager.textSecondary.opacity(0.4))
            Text("No jobs found")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)
            Text("Try adjusting your search or filters")
                .font(.system(size: 14))
                .foregroundStyle(themeManager.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var jobsList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.filteredJobs) { job in
                    Button {
                        navigationPath.append(job)
                    } label: {
                        JobCard(job: job)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.vertical, 8)
        }
        .refreshable {
            await viewModel.refreshJobs()
        }
        .navigationDestination(for: Job.self) { job in
            JobDetailView(job: job)
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

struct FilterChip: View {
    let label: String
    let onRemove: () -> Void
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.system(size: 9, weight: .bold))
            }
        }
        .foregroundStyle(ThemeManager.gold)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background {
            Capsule()
                .fill(ThemeManager.gold.opacity(0.12))
        }
    }
}
