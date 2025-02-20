//
//  UserDefoults+.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-15.
//

import Foundation

extension UserDefaults {
    
    var isAddedToBacket: Bool {
        get {
            return bool(forKey: "isAddedToBacket")
        }
        set {
            set(newValue, forKey: "isAddedToBacket")
        }
    }
    
    var userEmail: String {
        get {
            return string(forKey: "userEmail") ?? ""
        }
        set {
            set(newValue, forKey: "userEmail")
        }
    }
    
    var userName: String {
        get {
            return string(forKey: "userName") ?? ""
        }
        set {
            set(newValue, forKey: "userName")
        }
    }
}
