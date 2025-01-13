//
//  StateProperties.swift
//  The Ugly Duck
//
//  Created by Lev Vlasov on 2025-01-13.
//

import Foundation

final class StateProperties: ObservableObject {
    
    //MARK: - Properties
    @Published var apiService: APIService = APIService()
  
}
