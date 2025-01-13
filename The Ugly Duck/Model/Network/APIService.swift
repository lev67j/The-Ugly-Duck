//
//  APIService.swift
//  Rick and Morti
//
//  Created by Lev Vlasov on 15.07.2024.
//

import Foundation
import Combine


import Foundation
import Combine

@Observable
final class APIService {
    
    var results: [Results] = []
    var cancellable = Set<AnyCancellable>()
    
    func loadData() {
        
        //create url
        guard let url = URL(string: "https://freetestapi.com/api/v1/birds") else {
            return print("Invalid URL")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Results].self, decoder: JSONDecoder()) 
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch completion {
                    
                case .finished:
                    print("Good Network Birds")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
                
            } receiveValue: { decodeData in
                self.results = decodeData
            }
            .store(in: &cancellable)
    }
}
