import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    @State private var showSplash = true
    @State private var scaleEffect: CGFloat = 0.5
    @State private var rotationAngle: Double = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.95, blue: 1.0),
                    Color(red: 0.9, green: 0.9, blue: 0.95)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if showSplash {
                VStack(spacing: 30) {
                    // Main rabbit icon with animations
                    RabbitCrownIcon()
                        .frame(width: 120, height: 120)
                        .scaleEffect(scaleEffect)
                        .rotationEffect(.degrees(rotationAngle))
                        .opacity(opacity)
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                    
                    // App name or title
                    VStack(spacing: 8) {
                        Text("King company")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .opacity(opacity)
                        
                        Text("An expeerience like no other")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .opacity(opacity * 0.8)
                    }
                    .offset(y: isAnimating ? 0 : 20)
                    
                    // Loading indicator
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.2)
                        .opacity(opacity)
                }
                .onAppear {
                    startAnimations()
                }
            } else {
                // Transition to Login View after splash
                LoginView()
            }
        }
    }
    
    private func startAnimations() {
        // Initial fade in and scale animation
        withAnimation(.easeOut(duration: 0.8)) {
            opacity = 1.0
            scaleEffect = 1.0
        }
        
        // Bounce effect after initial animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                scaleEffect = 1.1
            }
            
            // Return to normal size
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    scaleEffect = 1.0
                }
            }
        }
        
        // Subtle rotation animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut(duration: 0.5)) {
                rotationAngle = 5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    rotationAngle = -5
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        rotationAngle = 0
                    }
                }
            }
        }
        
        // Text slide in animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut(duration: 0.6)) {
                isAnimating = true
            }
        }
        
        // Transition to main content after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                showSplash = false
            }
        }
    }
}

// Custom rabbit crown icon recreated in SwiftUI
struct RabbitCrownIcon: View {
    var body: some View {
        ZStack {
            // Rabbit body
            RabbitShape()
                .fill(Color.white)
                .stroke(Color.black, lineWidth: 4)
            
            // Crown
            Crown()
                .offset(x: 15, y: -25)
            
            // Rabbit features
            RabbitFeatures()
        }
    }
}

struct RabbitShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Main body (oval)
        let bodyRect = CGRect(x: width * 0.2, y: height * 0.4, width: width * 0.6, height: width * 0.5)
        path.addEllipse(in: bodyRect)
        
        // Head (circle)
        let headCenter = CGPoint(x: width * 0.6, y: height * 0.35)
        let headRadius = width * 0.25
        path.addEllipse(in: CGRect(x: headCenter.x - headRadius, y: headCenter.y - headRadius,
                                  width: headRadius * 2, height: headRadius * 2))
        
        // Left ear
        path.move(to: CGPoint(x: width * 0.45, y: height * 0.15))
        path.addQuadCurve(to: CGPoint(x: width * 0.35, y: height * 0.35),
                         control: CGPoint(x: width * 0.3, y: height * 0.2))
        path.addQuadCurve(to: CGPoint(x: width * 0.5, y: height * 0.25),
                         control: CGPoint(x: width * 0.4, y: height * 0.3))
        
        // Tail
        let tailCenter = CGPoint(x: width * 0.15, y: height * 0.7)
        path.addEllipse(in: CGRect(x: tailCenter.x - 8, y: tailCenter.y - 8, width: 16, height: 16))
        
        return path
    }
}

struct Crown: View {
    var body: some View {
        ZStack {
            // Crown base
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.yellow)
                .frame(width: 40, height: 12)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 2)
                )
            
            // Crown points
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: index == 1 ? 12 : 8, height: index == 1 ? 12 : 8)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        .offset(y: index == 1 ? -8 : -4)
                }
            }
            
            // Crown jewels
            HStack(spacing: 12) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.yellow.opacity(0.8))
                        .frame(width: 3, height: 3)
                        .offset(y: index == 1 ? -8 : -4)
                }
            }
        }
    }
}

struct RabbitFeatures: View {
    var body: some View {
        VStack {
            HStack(spacing: 25) {
                // Eye
                Circle()
                    .fill(Color.black)
                    .frame(width: 6, height: 6)
                    .offset(x: 15, y: -5)
                
                // Nose
                Circle()
                    .fill(Color.black)
                    .frame(width: 4, height: 4)
                    .offset(x: 8, y: 5)
            }
        }
    }
}

// This will be replaced with your existing ContentView
// Remove this struct and replace MainContentView() below with ContentView()

// Preview
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

// MARK: - Usage in your main App file
/*
To make this appear when you first open the app and then go to LoginView:

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView() // Shows splash first, then LoginView
        }
    }
}

Alternative approach - if you want more control over the transition:

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        // Auto-dismiss after 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showSplash = false
                            }
                        }
                    }
            } else {
                LoginView()
                    .transition(.opacity)
            }
        }
    }
}
*/
