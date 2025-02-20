//
//  LoginView.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-16.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @EnvironmentObject var stateProperties: StateProperties
    @EnvironmentObject var userService: UserService
   
    var body: some View {
        VStack {
            Text("Login Please")
                .font(.title)
                .padding()
            
            // button
            Button {
                
            } label: {
                Text("Email/Password")
            }
            .frame(height: 45)
            .clipShape(.capsule)
            .padding()
            
            //  GoogleSignInButton()
            .padding()
            .frame(height: 50)
            .onTapGesture {
                //     signInWithGoogle()
            }
            
            SignInWithAppleButton(.signIn) { request in
                let nonce = userService.randomNonceString()
                userService.nonce = nonce
                request.requestedScopes = [.email, .fullName]
                request.nonce = userService.sha256(nonce)
            } onCompletion: { result in
                switch result {
                case .success(let autorizetion):
                    userService.login_firebase(authorization: autorizetion)
                case .failure(let error):
                    userService.showError(error.localizedDescription)
                }
            }
            .frame(height: 45)
            .clipShape(.capsule)
            .padding()
        }
        .alert(userService.errorMessage, isPresented: $userService.isErrorAlert){}
    }
}
