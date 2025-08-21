//
//  UserauthApp.swift
//  Userauth
//
//  Created by Tarik Eddins on 6/30/25.
//
import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
 func application(_ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  FirebaseApp.configure()
  return true
 }
}
@main
struct UserAuthApp: App {
 // register app delegate for Firebase setup
 @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
 var body: some Scene {
  WindowGroup {
   NavigationView {
    LoginView()
   }
  }
 }
}
