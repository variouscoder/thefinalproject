//
//  LoginView.swift
//  Userauth
//
//  Created by Tarik Eddins on 7/1/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showingSignUp = false
    @State private var showConfetti = false
    @State private var navigateToMain = false
    @State private var navigateToSignUp = false  // Added this state
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.153, green: 0.137, blue: 0.227)
                    .ignoresSafeArea()
                
                // Confetti Effect
                if showConfetti {
                    ConfettiView()
                }
                
                VStack(spacing: 24) {
                    Text("Log In")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 85)
                    
                    VStack(spacing: 34) {
                        // Email Input
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 90)
                                .fill(Color.black)
                                .frame(height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 90)
                                        .stroke(Color(white: 0.908), lineWidth: 1)
                                )
                            
                            TextField("Email", text: $email)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .padding(.horizontal, 16)
                        }
                        
                        // Password Input
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 90)
                                .fill(Color.black)
                                .frame(height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 90)
                                        .stroke(Color(white: 0.908), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.25), radius: 4, y: 4)
                            
                            HStack {
                                if isPasswordVisible {
                                    TextField("Password", text: $password)
                                } else {
                                    SecureField("Password", text: $password)
                                }
                                
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Text(isPasswordVisible ? "Hide" : "Show")
                                        .foregroundColor(Color(red: 0.729, green: 0.231, blue: 0.275))
                                }
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.horizontal, 33)
                    .padding(.top, 52)
                    
                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14, weight: .medium))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 33)
                    }
                    
                    // Login Button
                    Button(action: {
                        signIn()
                    }) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        } else {
                            Text("Log In")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 51)
                    .background(Color.black)
                    .cornerRadius(100)
                    .padding(.horizontal, 33)
                    .padding(.top, 46)
                    .disabled(isLoading || email.isEmpty || password.isEmpty)
                    .opacity((isLoading || email.isEmpty || password.isEmpty) ? 0.6 : 1.0)
                    
                    VStack(spacing: 14) {
                        Button(action: {
                            forgotPassword()
                        }) {
                            Text("Forgot your password?")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.729, green: 0.231, blue: 0.275))
                        }
                        
                        // Updated Sign Up Button with programmatic navigation
                        Button(action: {
                            navigateToSignUp = true
                        }) {
                            Text("New user? sign up here")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0.729, green: 0.231, blue: 0.275))
                        }
                    }
                    
                    Spacer()
                    
                    // Background Image
                    Image("vro")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .clipped()
                }
            }
            .navigationBarHidden(true)
            .background(
                // Navigation Links
                VStack {
                    NavigationLink(destination: SwiftUIView(), isActive: $navigateToMain) {
                        EmptyView()
                    }
                    NavigationLink(destination: SignUpView(), isActive: $navigateToSignUp) {
                        EmptyView()
                    }
                }
                .hidden()
            )
        }
    }
    
    // MARK: - Authentication Functions
    private func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = getErrorMessage(from: error)
                } else {
                    // Login successful - show confetti and navigate
                    showConfetti = true
                    
                    // Navigate to main view after confetti animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigateToMain = true
                    }
                }
            }
        }
    }
    
    private func forgotPassword() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address first"
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = getErrorMessage(from: error)
                } else {
                    errorMessage = "Password reset email sent to \(email)"
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func getErrorMessage(from error: Error) -> String {
        if let authError = error as NSError?, let errorCode = AuthErrorCode(rawValue: authError.code) {
            switch errorCode {
            case .invalidEmail:
                return "Invalid email address"
            case .userNotFound:
                return "No account found with this email"
            case .wrongPassword:
                return "Incorrect password"
            case .userDisabled:
                return "This account has been disabled"
            case .tooManyRequests:
                return "Too many attempts. Please try again later"
            case .networkError:
                return "Network error. Please check your connection"
            default:
                return "Login failed. Please try again"
            }
        }
        return error.localizedDescription
    }
}

// MARK: - Confetti View
struct ConfettiView: View {
    @State private var confettiPieces: [ConfettiPiece] = []
    
    var body: some View {
        ZStack {
            ForEach(confettiPieces, id: \.id) { piece in
                Rectangle()
                    .fill(piece.color)
                    .frame(width: 8, height: 8)
                    .position(x: piece.x, y: piece.y)
                    .rotationEffect(.degrees(piece.rotation))
                    .opacity(piece.opacity)
            }
        }
        .onAppear {
            createConfetti()
            animateConfetti()
        }
    }
    
    private func createConfetti() {
        let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]
        
        for _ in 0..<50 {
            let piece = ConfettiPiece(
                id: UUID(),
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: -20,
                color: colors.randomElement() ?? .blue,
                rotation: Double.random(in: 0...360),
                opacity: 1.0
            )
            confettiPieces.append(piece)
        }
    }
    
    private func animateConfetti() {
        withAnimation(.easeOut(duration: 2.0)) {
            for i in 0..<confettiPieces.count {
                confettiPieces[i].y = UIScreen.main.bounds.height + 50
                confettiPieces[i].x += CGFloat.random(in: -100...100)
                confettiPieces[i].rotation += Double.random(in: 180...540)
                confettiPieces[i].opacity = 0.0
            }
        }
    }
}

struct ConfettiPiece {
    let id: UUID
    var x: CGFloat
    var y: CGFloat
    let color: Color
    var rotation: Double
    var opacity: Double
}

#Preview {
    LoginView()
}
