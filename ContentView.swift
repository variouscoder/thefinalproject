import SwiftUI


struct ContentView: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView() // This will show splash, then LoginView
        }
    }
}
