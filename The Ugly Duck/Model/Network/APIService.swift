//
//  APIService.swift
//  Rick and Morti
//
//  Created by Lev Vlasov on 15.07.2024.
//

import Foundation
import Combine

@Observable
final class APIService {
    
    var results: [Results] = []
    var cancellable = Set<AnyCancellable>()
    
    func loadData() {
        
        //create url
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            return print("Invalid URL")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {
                $0.data
            }
            .decode(type: NetworkModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch completion {
                    
                case .finished:
                    print("Good network")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            } receiveValue: { decodeData in
                self.results = decodeData.results
            }
            .store(in: &cancellable)
    }
}
