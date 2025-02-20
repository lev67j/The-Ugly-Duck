//
//  AccountView.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-16.
//


import SwiftUI
import FirebaseAuth

struct AccountView: View {
    
    @EnvironmentObject var stateProperties: StateProperties
    @EnvironmentObject var userService: UserService
    
    @State var userEmail: String
    @State var userName: String?
   
    var body: some View {
        VStack {
            Text("Welcome back, \(userEmail)")
                .font(.title)
                .padding()
            
            Button("Log Out") {
                logoutUser()
            }
        }
    }
    
    private func logoutUser() {
           do {
               try Auth.auth().signOut()
               userService.clearUser()
               
               self.userEmail = ""
           } catch {
               print("Error signing out: \(error.localizedDescription)")
           }
       }
}
