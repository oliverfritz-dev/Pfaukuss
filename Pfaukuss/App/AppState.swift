import SwiftUI
import Supabase
import Combine

@MainActor
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = true

    init() {
        Task {
            await checkSession()
        }
    }

    func checkSession() async {
        do {
            _ = try await supabase.auth.session
            isLoggedIn = true
        } catch {
            isLoggedIn = false
        }
        isLoading = false
    }
}
