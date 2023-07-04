import SwiftUI

@main struct SteadiApp: App {

    
    @State private var isLoggedin  = false
    @State private var currentUser = User(username: "", email: "", password: "")
    
    init() {
        let storedUsername = UserDefaults.standard.string(forKey: "username")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
    }

    
    var body: some Scene {
        WindowGroup {
            if isLoggedin {
                TabView {
                    JournalEntryView().tabItem {
                        Label("Journal", systemImage: "pencil")
                    }

                    ContentView().tabItem {
                        Label("Test", systemImage: "hand.wave.fill")
                    }
                    
                    UserView(user: $currentUser).tabItem {
                        Label("User", systemImage: "person")
                    }
                }
            } else {
                
                LoginView(user: $currentUser, isLoggedIn: $isLoggedin)
                
            }
        }
    }
}
