//
//  The_Ugly_DuckApp.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI
import FirebaseCore

final class AppDelegate: NSObject, UIApplicationDelegate { func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool { FirebaseApp.configure(); return true}}


@main
struct The_Ugly_DuckApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var stateProperties = StateProperties()
    @StateObject private var userService = UserService()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                
                // Header "The Ugly Duck"
                HStack {
                    HStack {
                        Image("HeaderApp")
                            .resizable()
                            .scaledToFill()
                            .scaledToFit()
                        
                        Spacer()
                    }
                    .frame(width: 200, height: 40)
                    .padding(10)
                    
                    Spacer()
                }
                
                TabView {
                    HomeView()
                        .environmentObject(stateProperties)
                        .tabItem {
                            Image(systemName: "house")
                            
                            Text("Home")
                        }
                    
                    NewsView()
                        .environmentObject(stateProperties)
                        .tabItem {
                            Image(systemName: "newspaper")
                            
                            Text("News")
                        }
                    
                    BasketView()
                        .environmentObject(stateProperties)
                        .tabItem {
                            Image(systemName: "basket")
                            
                            Text("Basket")
                        }
                    
                    
                    if let email = UserService().getUserEmail() {
                        // email was saved
                        AccountView(userEmail: email, userName: UserService().getUserName())
                            .environmentObject(stateProperties)
                            .environmentObject(userService)
                            .tabItem {
                                Image(systemName: "person")
                                
                                Text("Account")
                            }
                    } else {
                        // No data about user
                        LoginView()
                            .environmentObject(userService)
                            .environmentObject(stateProperties)
                            .tabItem {
                                Image(systemName: "person")
                                
                                Text("Account")
                            }
                    }
                }
            }
            .onAppear {
                stateProperties.apiService.loadData()
            }
        }
    }
}
