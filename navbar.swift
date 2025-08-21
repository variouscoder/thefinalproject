import SwiftUI

struct Navbar: View {
    var body: some View {
        NavigationView {
            MenuView()
                .navigationBarHidden(true)
        }
    }
}

struct MenuView: View {
    @State private var showingLogoutAlert = false
    
    var body: some View {
        ZStack {
            Color(red: 0.77, green: 0.80, blue: 0.79)
                .opacity(0.79)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top search bar
                HStack {
                    Text("King company")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 30)
                    
                    Capsule()
                        .fill(Color.black)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(white: 0.91), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.horizontal)
                .padding(.top, 27)
                
                // Main image with navigation buttons - NOW WITH CROWN BACKGROUND
                ZStack {
                    // Crown Background
                    CrownBackgroundView()
                        .frame(maxWidth: 412, maxHeight: 638)
                    
                    VStack(spacing: 85) {
                        // Subscriptions button (Mail icon)
                        NavigationLink(destination: SubscriptionsView()) {
                            Capsule()
                                .fill(Color.black)
                                .frame(height: 51)
                                .overlay(
                                    Image(systemName: "envelope.open")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                )
                                .scaleEffect(1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: 1.0)
                        }
                        .buttonStyle(InteractiveButtonStyle())
                        
                        // Contact Me button (Chat icon)
                        NavigationLink(destination: ContactView()) {
                            Capsule()
                                .fill(Color.black)
                                .frame(height: 51)
                                .overlay(
                                    Image(systemName: "bubble.left.and.bubble.right")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                )
                        }
                        .buttonStyle(InteractiveButtonStyle())
                        
                        // About Me button (Cart icon repurposed)
                        NavigationLink(destination: AboutView()) {
                            Capsule()
                                .fill(Color.black)
                                .frame(height: 51)
                                .overlay(
                                    Image(systemName: "person.circle")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                )
                        }
                        .buttonStyle(InteractiveButtonStyle())
                        
                        // Settings button
                        NavigationLink(destination: SettingsView()) {
                            Capsule()
                                .fill(Color.black)
                                .frame(height: 51)
                                .overlay(
                                    Image(systemName: "gearshape")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                )
                        }
                        .buttonStyle(InteractiveButtonStyle())
                    }
                    .padding(.horizontal, 27)
                    .padding(.vertical, 50)
                }
                
                // Bottom logout section
                HStack {
                    Text("log out")
                        .font(.system(size: 16, weight: .medium))
                    
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        Capsule()
                            .fill(Color.black)
                            .frame(height: 50)
                            .overlay(
                                HStack {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                            )
                            .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                    }
                    .buttonStyle(InteractiveButtonStyle())
                }
                .padding(.horizontal)
                .padding(.top, 50)
                
                // Logo placeholder
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 46, height: 72)
                    .overlay(
                        Text("LOGO")
                            .font(.caption)
                            .foregroundColor(.gray)
                    )
                    .rotationEffect(Angle(degrees: -0.38))
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .alert("Logout", isPresented: $showingLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Logout", role: .destructive) {
                // Handle logout logic here
                print("User logged out")
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
}

// Custom Crown Background View
struct CrownBackgroundView: View {
    var body: some View {
        ZStack {
            // Elegant background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.purple.opacity(0.15),
                    Color.blue.opacity(0.1),
                    Color.indigo.opacity(0.05)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Multiple crown silhouettes for pattern effect
            VStack(spacing: 100) {
                HStack(spacing: 80) {
                    CrownSilhouette()
                        .frame(width: 120, height: 120)
                        .opacity(0.08)
                        .rotationEffect(.degrees(-15))
                    
                    CrownSilhouette()
                        .frame(width: 100, height: 100)
                        .opacity(0.06)
                        .rotationEffect(.degrees(10))
                }
                
                // Main central crown - larger and more prominent
                CrownSilhouette()
                    .frame(width: 200, height: 200)
                    .opacity(0.12)
                    .scaleEffect(1.2)
                
                HStack(spacing: 90) {
                    CrownSilhouette()
                        .frame(width: 90, height: 90)
                        .opacity(0.05)
                        .rotationEffect(.degrees(20))
                    
                    CrownSilhouette()
                        .frame(width: 110, height: 110)
                        .opacity(0.07)
                        .rotationEffect(.degrees(-10))
                }
            }
            .offset(y: -20)
            
            // Subtle sparkle effects
            ForEach(0..<15, id: \.self) { _ in
                SparkleView()
                    .position(
                        x: CGFloat.random(in: 50...350),
                        y: CGFloat.random(in: 100...500)
                    )
            }
        }
    }
}

// Crown Silhouette Shape
struct CrownSilhouette: View {
    var body: some View {
        ZStack {
            CrownShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.yellow.opacity(0.3),
                            Color.orange.opacity(0.2),
                            Color.purple.opacity(0.1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
}

// Crown Shape Path
struct CrownShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Crown base
        let baseHeight = height * 0.3
        let baseRect = CGRect(x: width * 0.1, y: height * 0.7, width: width * 0.8, height: baseHeight)
        path.addRoundedRect(in: baseRect, cornerSize: CGSize(width: 8, height: 8))
        
        // Crown points (5 points)
        let pointWidth = width * 0.15
        let pointPositions: [CGFloat] = [0.15, 0.3, 0.5, 0.7, 0.85]
        let pointHeights: [CGFloat] = [0.4, 0.6, 0.2, 0.6, 0.4] // Middle point tallest
        
        for (index, xPos) in pointPositions.enumerated() {
            let pointHeight = height * pointHeights[index]
            let pointX = width * xPos
            let pointY = height * 0.7
            
            // Create triangular crown point
            path.move(to: CGPoint(x: pointX - pointWidth/2, y: pointY))
            path.addLine(to: CGPoint(x: pointX, y: pointY - pointHeight))
            path.addLine(to: CGPoint(x: pointX + pointWidth/2, y: pointY))
            path.addLine(to: CGPoint(x: pointX - pointWidth/2, y: pointY))
            
            // Add jewel on each point
            let jewelRadius: CGFloat = 6
            let jewelCenter = CGPoint(x: pointX, y: pointY - pointHeight * 0.7)
            path.addEllipse(in: CGRect(x: jewelCenter.x - jewelRadius, y: jewelCenter.y - jewelRadius,
                                     width: jewelRadius * 2, height: jewelRadius * 2))
        }
        
        return path
    }
}

// Sparkle Effect View
struct SparkleView: View {
    @State private var isAnimating = false
    @State private var opacity: Double = 0
    
    var body: some View {
        Image(systemName: "sparkle")
            .font(.system(size: CGFloat.random(in: 8...16)))
            .foregroundColor(.yellow.opacity(0.6))
            .opacity(opacity)
            .scaleEffect(isAnimating ? 1.2 : 0.8)
            .onAppear {
                withAnimation(.easeInOut(duration: Double.random(in: 2...4)).repeatForever(autoreverses: true)) {
                    isAnimating.toggle()
                }
                withAnimation(.easeInOut(duration: Double.random(in: 1...3)).repeatForever(autoreverses: true)) {
                    opacity = Double.random(in: 0.3...0.8)
                }
            }
    }
}

// Interactive button style with animations
struct InteractiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Rest of your existing views remain the same...
// Subscriptions Page
struct SubscriptionsView: View {
    @State private var subscriptions = [
        Subscription(name: "Premium Plan", price: "$9.99/month", isActive: true),
        Subscription(name: "Pro Plan", price: "$19.99/month", isActive: false),
        Subscription(name: "Enterprise", price: "$49.99/month", isActive: false)
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Subscriptions")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    ForEach(subscriptions.indices, id: \.self) { index in
                        SubscriptionCard(
                            subscription: $subscriptions[index],
                            onToggle: { toggleSubscription(at: index) }
                        )
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding()
            }
        }
        .navigationTitle("Subscriptions")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleSubscription(at index: Int) {
        // Deactivate all other subscriptions
        for i in subscriptions.indices {
            subscriptions[i].isActive = (i == index) ? !subscriptions[i].isActive : false
        }
    }
}

struct Subscription {
    let name: String
    let price: String
    var isActive: Bool
}

struct SubscriptionCard: View {
    @Binding var subscription: Subscription
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(subscription.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(subscription.price)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: onToggle) {
                    Text(subscription.isActive ? "Active" : "Subscribe")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(subscription.isActive ? Color.green : Color.blue)
                        .cornerRadius(16)
                }
                .buttonStyle(InteractiveButtonStyle())
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// Contact Page
struct ContactView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.1), Color.blue.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    Text("Contact Me")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    VStack(spacing: 20) {
                        CustomTextField(text: $name, placeholder: "Your Name", icon: "person")
                        CustomTextField(text: $email, placeholder: "Email Address", icon: "envelope")
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "bubble.left.and.bubble.right")
                                    .foregroundColor(.blue)
                                Text("Message")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            
                            TextEditor(text: $message)
                                .frame(minHeight: 120)
                                .padding(12)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            showingAlert = true
                        }) {
                            HStack {
                                Image(systemName: "paperplane.fill")
                                Text("Send Message")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                        }
                        .buttonStyle(InteractiveButtonStyle())
                        .disabled(name.isEmpty || email.isEmpty || message.isEmpty)
                        .opacity(name.isEmpty || email.isEmpty || message.isEmpty ? 0.6 : 1.0)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(16)
                    
                    Spacer(minLength: 50)
                }
                .padding()
            }
        }
        .navigationTitle("Contact")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Message Sent!", isPresented: $showingAlert) {
            Button("OK") {
                name = ""
                email = ""
                message = ""
            }
        } message: {
            Text("Thank you for your message. I'll get back to you soon!")
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(placeholder)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.8))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

// About Page
struct AboutView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.1), Color.red.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    Text("About Me")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // Profile section
                    VStack(spacing: 15) {
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.red]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                            )
                        
                        Text("King Company")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Innovative Solutions Provider")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(16)
                    
                    // Info cards
                    VStack(spacing: 15) {
                        InfoCard(
                            icon: "lightbulb.fill",
                            title: "Mission",
                            description: "To provide innovative solutions that empower businesses and individuals to achieve their goals.",
                            color: .yellow
                        )
                        
                        InfoCard(
                            icon: "target",
                            title: "Vision",
                            description: "Creating a world where technology seamlessly integrates with human needs.",
                            color: .green
                        )
                        
                        InfoCard(
                            icon: "heart.fill",
                            title: "Values",
                            description: "Innovation, integrity, and customer satisfaction drive everything we do.",
                            color: .pink
                        )
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding()
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.title3)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
    }
}

// Settings Page
struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var autoSyncEnabled = true
    @State private var selectedLanguage = "English"
    
    let languages = ["English", "Spanish", "French", "German", "Chinese"]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.blue.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // Preferences section
                    SettingsSection(title: "Preferences") {
                        SettingsToggle(
                            title: "Push Notifications",
                            description: "Receive updates and alerts",
                            isOn: $notificationsEnabled,
                            icon: "bell.fill",
                            color: .blue
                        )
                        
                        SettingsToggle(
                            title: "Dark Mode",
                            description: "Use dark appearance",
                            isOn: $darkModeEnabled,
                            icon: "moon.fill",
                            color: .purple
                        )
                        
                        SettingsToggle(
                            title: "Auto Sync",
                            description: "Sync data automatically",
                            isOn: $autoSyncEnabled,
                            icon: "arrow.clockwise",
                            color: .green
                        )
                    }
                    
                    // Account section
                    SettingsSection(title: "Account") {
                        SettingsRow(
                            title: "Language",
                            value: selectedLanguage,
                            icon: "globe",
                            color: .orange
                        ) {
                            // Language selection action
                        }
                        
                        SettingsRow(
                            title: "Privacy Policy",
                            icon: "lock.shield",
                            color: .red
                        ) {
                            // Privacy policy action
                        }
                        
                        SettingsRow(
                            title: "Terms of Service",
                            icon: "doc.text",
                            color: .gray
                        ) {
                            // Terms action
                        }
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding()
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.horizontal)
            
            VStack(spacing: 1) {
                content
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(12)
        }
    }
}

struct SettingsToggle: View {
    let title: String
    let description: String
    @Binding var isOn: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 18))
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: color))
        }
        .padding()
    }
}

struct SettingsRow: View {
    let title: String
    let value: String?
    let icon: String
    let color: Color
    let action: () -> Void
    
    init(title: String, value: String? = nil, icon: String, color: Color, action: @escaping () -> Void) {
        self.title = title
        self.value = value
        self.icon = icon
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(color)
                            .font(.system(size: 18))
                    )
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if let value = value {
                    Text(value)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding()
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    Navbar()
}
