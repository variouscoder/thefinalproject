//  SwiftUIView.swift
//  Userauth
//
//  Created by Tarik Eddins on 7/30/25.
//

import SwiftUI
import FirebaseAuth

struct SwiftUIView: View {
    @State private var navigateToLogin = false
    @State private var showingMembership = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.77, green: 0.80, blue: 0.79)
                    .opacity(0.79)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top bar
                    HStack {
                        Text("King company")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        NavigationLink(destination: Navbar()) {
                            Image(systemName: "person")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 27)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black)
                            .stroke(Color(white: 0.91), lineWidth: 1)
                    )
                    
                    // Mentors title
                    Text("Mentors")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    // Grid of circles
                    VStack(spacing: 32) {
                        HStack(spacing: 32) {
                            ForEach(0..<3, id: \.self) { _ in
                                Circle()
                                    .fill(Color(white: 0.85))
                                    .frame(width: 75, height: 75)
                            }
                        }
                        
                        HStack(spacing: 32) {
                            ForEach(0..<3, id: \.self) { _ in
                                Circle()
                                    .fill(Color(white: 0.85))
                                    .frame(width: 75, height: 75)
                            }
                        }
                        
                        HStack(spacing: 32) {
                            ForEach(0..<3, id: \.self) { _ in
                                Circle()
                                    .fill(Color(white: 0.85))
                                    .frame(width: 75, height: 75)
                            }
                        }
                        
                        HStack(spacing: 32) {
                            ForEach(0..<3, id: \.self) { _ in
                                Circle()
                                    .fill(Color(white: 0.85))
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    // Bottom bar with logout and menu functionality
                    HStack {
                        Button(action: {
                            signOutAndNavigate()
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                
                                Text("log out")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: Navbar()) {
                            HStack {
                                Image(systemName: "line.horizontal.3")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                
                                Text("Menu")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 360)
                            .fill(Color.black)
                            .stroke(Color(white: 0.91), lineWidth: 1)
                    )
                }
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
    
    // MARK: - Logout Function
    private func signOutAndNavigate() {
        do {
            try Auth.auth().signOut()
            // Navigate back to login page after successful logout
            navigateToLogin = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

#Preview {
    SwiftUIView()
}
