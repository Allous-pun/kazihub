import SwiftUI

struct MainTabView: View {
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var jobFeedVM = JobFeedViewModel()
    @StateObject private var applicationsVM = ApplicationsViewModel()
    @StateObject private var messagesVM = MessagesViewModel()
    @StateObject private var profileVM = ProfileViewModel()
    @StateObject private var paymentVM = PaymentViewModel()

    @State private var selectedTab: Tab = .home
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    JobFeedView(navigationPath: $navigationPath)
                        .tag(Tab.home)
                        .environmentObject(jobFeedVM)
                        .environmentObject(paymentVM)

                    MyApplicationsView()
                        .tag(Tab.applications)
                        .environmentObject(applicationsVM)

                    MessagesView()
                        .tag(Tab.messages)
                        .environmentObject(messagesVM)

                    ProfileView()
                        .tag(Tab.profile)
                        .environmentObject(profileVM)
                        .environmentObject(themeManager)
                }
                .tabViewStyle(.tabBarOnly)

                customTabBar
            }
        }
        .environmentObject(jobFeedVM)
        .environmentObject(applicationsVM)
        .environmentObject(messagesVM)
        .environmentObject(profileVM)
        .environmentObject(paymentVM)
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }

    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases) { tab in
                tabBarButton(for: tab)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .padding(.bottom, 24)
        .background {
            Rectangle()
                .fill(themeManager.surface)
                .overlay(alignment: .top) {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundStyle(themeManager.textSecondary.opacity(0.15))
                }
                .ignoresSafeArea(edges: .bottom)
        }
    }

    private func tabBarButton(for tab: Tab) -> some View {
        let isSelected = selectedTab == tab

        return Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(ThemeManager.gold.opacity(0.15))
                            .frame(width: 42, height: 42)
                            .transition(.scale.combined(with: .opacity))
                    }

                    Image(systemName: tab.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(isSelected ? ThemeManager.gold : themeManager.textSecondary)
                }
                .frame(height: 42)

                Text(tab.title)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .medium))
                    .foregroundStyle(isSelected ? ThemeManager.gold : themeManager.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .topTrailing) {
                if tab == .applications, applicationsVM.notificationBadgeCount > 0 {
                    badge(count: applicationsVM.notificationBadgeCount)
                }
                if tab == .messages, messagesVM.totalUnread > 0 {
                    badge(count: messagesVM.totalUnread)
                }
            }
        }
    }

    private func badge(count: Int) -> some View {
        Text("\(count)")
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 18, height: 18)
            .background(Circle().fill(Color.red))
            .offset(x: 14, y: -4)
    }
}

enum Tab: String, Identifiable, CaseIterable {
    case home, applications, messages, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .applications: return "Applications"
        case .messages: return "Messages"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .applications: return "doc.text.fill"
        case .messages: return "message.fill"
        case .profile: return "person.fill"
        }
    }
}
