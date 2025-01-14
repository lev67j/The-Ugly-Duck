//
//  The_Ugly_DuckApp.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import SwiftUI

@main
struct The_Ugly_DuckApp: App {
    
    @StateObject private var stateProperties = StateProperties()
    
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
                    
                    AccountView()
                        .environmentObject(stateProperties)
                        .tabItem {
                            Image(systemName: "person")
                            
                            Text("Account")
                        }
                }
            }
            .onAppear {
                stateProperties.apiService.loadData()
            }
        }
    }
}
