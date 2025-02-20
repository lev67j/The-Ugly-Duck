//
//  UserService.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-16.
//


import Foundation
import CryptoKit
import AuthenticationServices
import FirebaseAuth

final class UserService: ObservableObject {
    
    //MARK: - Properties
    
    // User data
    @Published var isLoginUser = false
    @Published var nonce: String? = ""
    
    // User personal data
    @Published var emailUser = ""
    @Published var passwordUser = ""
    
     
    // error
    @Published var errorMessage = ""
    @Published var isErrorAlert = false
  
    
    
    private let userEmailKey = "userEmail"
    private let userNameKey = "userName"
    
    // save
    func saveUserEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: userEmailKey)
    }
    
    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: userNameKey)
    }
    
    // get
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    func getUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: userEmailKey)
    }
   
    // clear
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: userEmailKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
    }
    
    
    // show error
    func showError(_ message: String) {
        errorMessage = message
        isErrorAlert.toggle()
    }
    
    
    // another
    func login_firebase(authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce else {
                showError("Cannot process your request")
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                showError("Cannot process your request")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                showError("Cannot process your request")
                return
            }
            // Initialize a Firebase credential, including the user's full name.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                           rawNonce: nonce,
                                                           fullName: appleIDCredential.fullName)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error {
                    self.showError(error.localizedDescription)
                    return
                }
                
                // login user!
                self.isLoginUser = true
                // isLoading = true // next step
            }
        }
    }
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
