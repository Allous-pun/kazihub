import SwiftUI

struct FilterSheet: View {
    @EnvironmentObject private var viewModel: JobFeedViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: JobCategory? = nil
    @State private var selectedLocation: String? = nil

    var body: some View {
        ZStack {
            themeManager.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                // Header
                HStack {
                    Text("Filters")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(themeManager.textPrimary)

                    Spacer()

                    Button("Reset") {
                        selectedCategory = nil
                        selectedLocation = nil
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(ThemeManager.gold)
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 20)

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        categorySection
                        locationSection
                    }
                    .padding(.horizontal, 20)
                }

                applyButton
            }
        }
        .onAppear {
            selectedCategory = viewModel.selectedCategory
            selectedLocation = viewModel.selectedLocation
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Category")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                ForEach(JobCategory.allCases, id: \.self) { category in
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            selectedCategory = selectedCategory == category ? nil : category
                        }
                    } label: {
                        Text(category.rawValue)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(
                                selectedCategory == category
                                    ? ThemeManager.gold
                                    : themeManager.textSecondary
                            )
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        selectedCategory == category
                                            ? ThemeManager.gold.opacity(0.12)
                                            : themeManager.surfaceSecondary
                                    )
                                    .overlay {
                                        if selectedCategory == category {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(ThemeManager.gold, lineWidth: 1)
                                        }
                                    }
                            }
                    }
                }
            }
        }
    }

    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Location")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(themeManager.textPrimary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 8)], spacing: 8) {
                ForEach(viewModel.availableLocations, id: \.self) { location in
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            selectedLocation = selectedLocation == location ? nil : location
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.system(size: 11))
                            Text(location)
                                .font(.system(size: 13, weight: .medium))
                                .lineLimit(1)
                        }
                        .foregroundStyle(
                            selectedLocation == location
                                ? ThemeManager.gold
                                : themeManager.textSecondary
                        )
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    selectedLocation == location
                                        ? ThemeManager.gold.opacity(0.12)
                                        : themeManager.surfaceSecondary
                                )
                                .overlay {
                                    if selectedLocation == location {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(ThemeManager.gold, lineWidth: 1)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }

    private var applyButton: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(themeManager.textSecondary.opacity(0.1))

            Button {
                viewModel.applyFilters(category: selectedCategory, location: selectedLocation)
                dismiss()
            } label: {
                Text("Apply Filters")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(ThemeManager.gold)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
    }
}
