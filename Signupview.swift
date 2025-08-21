import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(red: 0.153, green: 0.137, blue: 0.227)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Sign up")
                        .font(.system(size: 45, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 30) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("Email", text: $email)
                                .padding(16)
                                .frame(height: 50)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(white: 0.908), lineWidth: 1)
                                )
                                .cornerRadius(8)
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 0) {
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
                            .padding(16)
                            .frame(height: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(white: 0.908), lineWidth: 1)
                            )
                            .cornerRadius(8)
                        }
                        
                        // Confirm Password Field
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                if isConfirmPasswordVisible {
                                    TextField("Confirm Password", text: $confirmPassword)
                                } else {
                                    SecureField("Confirm Password", text: $confirmPassword)
                                }
                                
                                Button(action: {
                                    isConfirmPasswordVisible.toggle()
                                }) {
                                    Text(isConfirmPasswordVisible ? "Hide" : "Show")
                                        .foregroundColor(Color(red: 0.729, green: 0.231, blue: 0.275))
                                }
                            }
                            .padding(16)
                            .frame(height: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(white: 0.908), lineWidth: 1)
                            )
                            .cornerRadius(8)
                        }
                        
                        // Password Requirements
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Password must contain:")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text("• At least 6 characters")
                                .font(.system(size: 12))
                                .foregroundColor(password.count >= 6 ? .green : .white.opacity(0.6))
                            
                            Text("• Passwords must match")
                                .font(.system(size: 12))
                                .foregroundColor((!password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword) ? .green : .white.opacity(0.6))
                        }
                        .padding(.horizontal, 4)
                        
                        // Error/Success Messages
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.system(size: 14, weight: .medium))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        
                        if !successMessage.isEmpty {
                            Text(successMessage)
                                .foregroundColor(.green)
                                .font(.system(size: 14, weight: .medium))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        
                        // Sign Up Button
                        Button(action: {
                            signUp()
                        }) {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0.729, green: 0.231, blue: 0.275)))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Sign Up")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color(red: 0.729, green: 0.231, blue: 0.275))
                            }
                        }
                        .frame(width: 150, height: 50)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(white: 0.908), lineWidth: 1)
                        )
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .disabled(isLoading || !isFormValid())
                        .opacity((isLoading || !isFormValid()) ? 0.6 : 1.0)
                        
                        // Login Link
                        Button(action: {
                            dismiss() // Navigate back to login page
                        }) {
                            Text("Already have an account? Log in here")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0.729, green: 0.231, blue: 0.275))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 38)
                .padding(.vertical, 40)
            }
            
            // Background Image (positioned at the bottom)
            VStack {
                Spacer()
                
                Image("vro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300) // Adjust height as needed
                    .clipped()
                    .opacity(0.3) // Make it subtle so it doesn't interfere with content
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Authentication Functions
    private func signUp() {
        guard isFormValid() else {
            return
        }
        
        isLoading = true
        errorMessage = ""
        successMessage = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = getErrorMessage(from: error)
                } else {
                    successMessage = "Account created successfully!"
                    // Send email verification
                    sendEmailVerification()
                    
                    // Navigate back to login page after successful signup
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                print("Error sending verification email: \(error.localizedDescription)")
            } else {
                print("Verification email sent")
            }
        }
    }
    
    // MARK: - Validation Functions
    private func isFormValid() -> Bool {
        return !email.isEmpty &&
               !password.isEmpty &&
               !confirmPassword.isEmpty &&
               password.count >= 6 &&
               password == confirmPassword &&
               isValidEmail(email)
    }
    
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
            case .emailAlreadyInUse:
                return "An account with this email already exists"
            case .weakPassword:
                return "Password is too weak. Please choose a stronger password"
            case .networkError:
                return "Network error. Please check your connection"
            case .tooManyRequests:
                return "Too many requests. Please try again later"
            default:
                return "Account creation failed. Please try again"
            }
        }
        return error.localizedDescription
    }
}

#Preview {
    SignUpView()
}
